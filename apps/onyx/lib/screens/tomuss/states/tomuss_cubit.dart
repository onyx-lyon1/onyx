import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
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
    List<TeachingUnit> teachingUnits = [];
    List<Semester> semesters = [];

    SemesterList? semesterModelWrapper = await CacheService.get<SemesterList>();
    if (semestreIndex != null) {
      semesterModelWrapper =
          semesterModelWrapper?.copyWith(currentSemesterIndex: semestreIndex) ??
              SemesterList(const [], currentSemesterIndex: semestreIndex);
    }
    if (semesterModelWrapper != null) {
      await CacheService.set<SemesterList>(semesterModelWrapper);
      semestreIndex ??= semesterModelWrapper.currentSemesterIndex;
      semesters = semesterModelWrapper.semestres;
    }
    if (cache && !kIsWeb) {
      teachingUnits = await compute(TomussLogic.getTeachingUnitsCache, (
        path: (await getApplicationDocumentsDirectory()).path,
        currentSemesterIndex: semestreIndex ?? 0
      ));
      emit(state.copyWith(
        status: TomussStatus.cacheReady,
        teachingUnits: teachingUnits,
        semesters: semesterModelWrapper?.semestres ?? [],
        currentSemesterIndex: semestreIndex ?? 0,
        newElements: TomussLogic.parseRecentElements(teachingUnits, settings),
      ));
    }
    if (_dartus != null && _dartus!.lyon1Cas.isAuthenticated) {
      try {
        ({
          List<Semester>? semesters,
          List<TeachingUnit>? schoolSubjectModel,
          Duration? timeout,
        }) result = await TomussLogic.getSemestersAndNote(
            dartus: _dartus!,
            semesterIndex: semestreIndex,
            autoRefresh: false,
            semester: (semesters.length > (semestreIndex ?? 0))
                ? semesters[semestreIndex ?? 0]
                : null);
        if (result.timeout != null) {
          emit(state.copyWith(
            currentSemesterIndex: semestreIndex ?? 0,
            status: TomussStatus.timeout,
            timeout: result.timeout,
            newElements:
                TomussLogic.parseRecentElements(teachingUnits, settings),
          ));
          _loading = false;
          return;
        }
        semestreIndex ??= result.semesters!.indexWhere(
            (element) => element.url == Lyon1TomussClient.currentSemester());
        semesters = result.semesters!;
        teachingUnits = result.schoolSubjectModel!;
      } catch (e) {
        Res.logger.e("Error while loading grades: $e");
        emit(state.copyWith(status: TomussStatus.error));
        _loading = false;
        return;
      }

      teachingUnits.sort((a, b) => a.title.compareTo(b.title));
      CacheService.set<TeachingUnitList>(
          TeachingUnitList(teachingUnits, semestreIndex),
          index: semestreIndex);
      CacheService.set<SemesterList>(
          SemesterList(semesters, currentSemesterIndex: semestreIndex));
      emit(state.copyWith(
        status: TomussStatus.ready,
        teachingUnits: teachingUnits,
        semesters: semesters,
        currentSemesterIndex: semestreIndex,
        newElements: TomussLogic.parseRecentElements(teachingUnits, settings),
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
    grade = grade.copyWith.coef(coef ?? 1.0);
    teachingUnits[index].grades[gradeIndex] = grade;

    //save in cache
    await CacheService.set<TeachingUnitList>(
        TeachingUnitList(teachingUnits, state.currentSemesterIndex));
    emit(state.copyWith(
        status: TomussStatus.updated, teachingUnits: teachingUnits));
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
    enumeration = enumeration.copyWith.value(value);

    teachingUnits[index].enumerations[enumerationIndex] = enumeration;
    await CacheService.set<TeachingUnitList>(
        TeachingUnitList(teachingUnits, state.currentSemesterIndex));

    if (recentElementIndex != -1) {
      newElements[recentElementIndex] = (
        teachingUnit: state.newElements[recentElementIndex].teachingUnit,
        teachingUnitElement: (state.newElements[recentElementIndex]
                .teachingUnitElement as Enumeration)
            .copyWith
            .value(value)
      );
    }
    emit(state.copyWith(
        status: TomussStatus.updated,
        teachingUnits: teachingUnits,
        newElements: newElements));
  }

  void resetCubit() async {
    emit(const TomussState(status: TomussStatus.initial));
  }
}
