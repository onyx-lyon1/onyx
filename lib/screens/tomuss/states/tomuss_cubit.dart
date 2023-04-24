import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';

import '../../settings/settings_export.dart';

part 'tomuss_state.dart';

class TomussCubit extends Cubit<TomussState> {
  TomussCubit() : super(TomussState(status: TomussStatus.initial));

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
        newGrades: TomussLogic.parseRecentGrades(teachingUnits, settings),
      ));
    }
    if (dartus != null) {
      try {
        GetSemesterAndNoteResultWaitingRecords result =
            await TomussLogic.getSemestersAndNote(
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
            newGrades: TomussLogic.parseRecentGrades(teachingUnits, settings),
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
        emit(TomussState(status: TomussStatus.error));
        return;
      }

      teachingUnits.sort((a, b) => a.name.compareTo(b.name));
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
        newGrades: TomussLogic.parseRecentGrades(teachingUnits, settings),
      ));
    }
  }

  Future<void> updateCoef(Grade grade, double? coef) async {
    grade = grade.copyWith.coef(coef ?? 1.0);
    //save in cache
    CacheService.set<TeachingUnitList>(
        TeachingUnitList(state.teachingUnits, state.currentSemesterIndex));
    emit(state.copyWith(
        status: TomussStatus.updated, teachingUnits: state.teachingUnits));
  }

  void resetCubit() async {
    emit(TomussState(status: TomussStatus.initial));
  }
}
