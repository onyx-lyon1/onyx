import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/extensions/list_extension.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';

import '../../settings/settings_export.dart';

part 'tomuss_state.dart';

part 'tomuss_cubit.mapper.dart';

class TomussCubit extends Cubit<TomussState> {
  Lyon1TomussClient? _dartus;
  bool _loading = false;

  TomussCubit() : super(const TomussState(status: TomussStatus.initial));

  Future<void> load({
    required Lyon1CasClient lyon1Cas,
    bool cache = true,
    int? semestreIndex,
    required SettingsModel settings,
    bool force = false,
  }) async {
    if (_loading && !force) {
      return;
    }
    _loading = true;
    emit(state.copyWith(
        status: TomussStatus.loading, currentSemesterIndex: semestreIndex));
    _dartus = Lyon1TomussClient(lyon1Cas);
    List<Semester> semesters = [];
    if (cache && !kIsWeb) {
      semesters = await compute(
        TomussLogic.getSemesterCache,
        (
          cachePath: (await getApplicationCacheDirectory()).path,
          permanentPath: (await getApplicationDocumentsDirectory()).path
        ),
      );
      emit(state.copyWith(
        status: TomussStatus.cacheReady,
        semesters: semesters,
        currentSemesterIndex: semestreIndex,
        newElements: TomussLogic.parseRecentElements(
            semesters
                .get(semestreIndex,
                    Semester("title", "url", teachingUnits: []))
                .teachingUnits,
            settings),
      ));
    }
    if (_dartus != null && _dartus!.lyon1Cas.isAuthenticated) {
      try {
        ({
          List<Semester>? semesters,
          Duration? timeout,
        }) result = await TomussLogic.getSemesters(
            dartus: _dartus!,
            semesterIndex: semestreIndex,
            autoRefresh: false,
            semester: (semestreIndex != null)
                //TODO check if using state.semesters don't create problem of unset
                ? (state.semesters.length > (semestreIndex))
                    ? state.semesters[semestreIndex]
                    : null
                : null);
        if (result.timeout != null) {
          emit(state.copyWith(
            currentSemesterIndex: semestreIndex,
            status: TomussStatus.timeout,
            timeout: result.timeout,
          ));
          _loading = false;
          return;
        }
        semestreIndex ??= result.semesters!.indexWhere((element) =>
            element.url == Lyon1TomussClient.currentSemester().url);
        if (semestreIndex == -1) {
          semestreIndex = result.semesters!.length - 1;
        }
        semesters = result.semesters!;
      } catch (e) {
        Res.logger.e("Error while loading grades: $e");
        emit(state.copyWith(status: TomussStatus.error));
        _loading = false;
        return;
      }

      semesters[semestreIndex]
          .teachingUnits
          .sort((a, b) => a.title.compareTo(b.title));
      if (CacheService.exist<List<Semester>>()) {
        List<Semester> cacheSemesters = CacheService.get<List<Semester>>()!;
        if (cacheSemesters.length > semestreIndex) {
          cacheSemesters[semestreIndex] = semesters[semestreIndex];
          semesters = cacheSemesters;
        }
      }
      CacheService.set<List<Semester>>(semesters);
      emit(state.copyWith(
        status: TomussStatus.ready,
        semesters: semesters,
        currentSemesterIndex: semestreIndex,
        newElements: TomussLogic.parseRecentElements(
            semesters[semestreIndex].teachingUnits, settings),
      ));
    }
    _loading = false;
  }

  Future<void> updateCoef(Grade grade, double? coef) async {
    //update state
    List<TeachingUnit> teachingUnits = state.teachingUnits;
    int index =
        teachingUnits.indexWhere((element) => element.grades.contains(grade));
    if (index == -1) {
      return;
    }
    int gradeIndex = teachingUnits[index].grades.indexOf(grade);
    grade = grade.copyWith(coef: coef ?? 1.0);
    teachingUnits[index].grades[gradeIndex] = grade;

    //TODO check if its really working
    List<Semester> semesters = state.semesters
      ..[state.currentSemesterIndex].copyWith(teachingUnits: teachingUnits);
    //save in cache
    CacheService.set<List<Semester>>(semesters);
    emit(state.copyWith(status: TomussStatus.updated, semesters: semesters));
  }

  Future<void> updateEnumerationValue(
      Enumeration enumeration, String value) async {
    List<TeachingUnit> teachingUnits = List.from(state.teachingUnits);
    final List<
        ({
          TeachingUnit teachingUnit,
          TeachingUnitElement teachingUnitElement
        })> newElements = List.from(state.newElements);
    int index = teachingUnits
        .indexWhere((element) => element.enumerations.contains(enumeration));
    int recentElementIndex = newElements
        .indexWhere((element) => element.teachingUnitElement == enumeration);
    if (index == -1) {
      return;
    }
    int enumerationIndex =
        teachingUnits[index].enumerations.indexOf(enumeration);
    await enumeration.updateValue(value, teachingUnits[index].ticket);
    enumeration = enumeration.copyWith(value: value);

    teachingUnits[index].enumerations[enumerationIndex] = enumeration;

    //TODO check if its really working
    List<Semester> semesters = state.semesters
      ..[state.currentSemesterIndex].copyWith(teachingUnits: teachingUnits);
    CacheService.set<List<Semester>>(semesters);

    if (recentElementIndex != -1) {
      newElements[recentElementIndex] = (
        teachingUnit: state.newElements[recentElementIndex].teachingUnit,
        teachingUnitElement: (state.newElements[recentElementIndex]
                .teachingUnitElement as Enumeration)
            .copyWith(value: value)
      );
    }
    emit(state.copyWith(
        status: TomussStatus.updated,
        semesters: semesters,
        newElements: newElements));
  }

  void resetCubit() async {
    emit(const TomussState(status: TomussStatus.initial));
  }
}
