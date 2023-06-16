import 'package:dartus/tomuss.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';

import '../../settings/settings_export.dart';

part 'tomuss_state.dart';

class TomussCubit extends Cubit<TomussState> {
  TomussCubit() : super(const TomussState(status: TomussStatus.initial));

  Future<void> load(
      {required Dartus? dartus,
      bool cache = true,
      int? semestreIndex,
      required SettingsModel settings}) async {
    emit(state.copyWith(
        status: TomussStatus.loading, currentSemesterIndex: semestreIndex));
    List<TeachingUnit> teachingUnits = [];
    List<Semester> semesters = [];

    SemesterList? semesterModelWrapper = await CacheService.get<SemesterList>();
    if (semesterModelWrapper != null) {
      semestreIndex ??= semesterModelWrapper.currentSemesterIndex;
      semesters = semesterModelWrapper.semestres;
    }
    if (cache) {
      teachingUnits = await compute(
          TomussLogic.getTeachingUnitsCache,
          GetCacheDataPass((await getApplicationDocumentsDirectory()).path,
              semestreIndex ?? 0));
      emit(state.copyWith(
        status: TomussStatus.cacheReady,
        teachingUnits: teachingUnits,
        semesters: semesterModelWrapper?.semestres ?? [],
        currentSemesterIndex: semestreIndex ?? 0,
        newElements: TomussLogic.parseRecentElements(teachingUnits, settings),
      ));
    }
    if (dartus != null) {
      try {
        ({
          List<Semester>? semesters,
          List<TeachingUnit>? schoolSubjectModel,
          Duration? timeout,
        }) result = await TomussLogic.getSemestersAndNote(
            dartus: dartus,
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
          return;
        }
        semestreIndex ??= result.semesters!
            .indexWhere((element) => element.url == Dartus.currentSemester());
        semesters = result.semesters!;
        teachingUnits = result.schoolSubjectModel!;
      } catch (e) {
        if (kDebugMode) {
          print("Error while loading grades: $e");
        }
        emit(const TomussState(status: TomussStatus.error));
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
      print("updating recent element");
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
