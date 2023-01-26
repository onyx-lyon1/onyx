import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';

part 'tomuss_state.dart';

class TomussCubit extends Cubit<TomussState> {
  TomussCubit() : super(TomussState(status: TomussStatus.initial));

  Future<void> load(
      {required Dartus? dartus, bool cache = true, int? semestreIndex}) async {
    print(semestreIndex);
    emit(state.copyWith(
        status: TomussStatus.loading, currentSemesterIndex: semestreIndex));
    List<SchoolSubjectModel> teachingUnits = [];
    List<SemestreModel> semesters = [];

    SemestreModelWrapper? semesterModelWrapper =
        await CacheService.get<SemestreModelWrapper>();
    if (semesterModelWrapper != null) {
      semestreIndex ??= semesterModelWrapper.currentSemestreIndex;
      semesters = semesterModelWrapper.semestres;
    }
    semestreIndex ??= 0;
    if (cache) {
      teachingUnits = await compute(
          TomussLogic.getTeachingUnitsCache,
          GetCacheDataPass(
              (await getApplicationDocumentsDirectory()).path, semestreIndex));
      emit(state.copyWith(
        status: TomussStatus.cacheReady,
        teachingUnits: teachingUnits,
        semesters: semesterModelWrapper?.semestres ?? [],
        currentSemesterIndex: semestreIndex,
      ));
    }
    if (dartus != null) {
      try {
        GetSemesterAndNoteResultWaitingRecords result =
            await TomussLogic.getSemestersAndNote(
                dartus: dartus,
                semesterIndex: semestreIndex,
                autoRefresh: false,
                semester: (semesters.length > semestreIndex)
                    ? semesters[semestreIndex]
                    : null);
        if (result.timeout != null) {
          emit(state.copyWith(
            currentSemesterIndex: semestreIndex,
            status: TomussStatus.loading,
            timeout: result.timeout,
          ));
          return;
        }
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
      CacheService.set<SchoolSubjectModelWrapper>(
          SchoolSubjectModelWrapper(teachingUnits, semestreIndex),
          index: semestreIndex);
      CacheService.set<SemestreModelWrapper>(
          SemestreModelWrapper(semesters, currentSemestreIndex: semestreIndex));
      emit(state.copyWith(
          status: TomussStatus.ready,
          teachingUnits: teachingUnits,
          semesters: semesters,
          currentSemesterIndex: semestreIndex));
    }
  }

  Future<void> updateCoef(GradeModel grade, double? coef) async {
    grade.coef = coef;
    //save in cache
    CacheService.set<SchoolSubjectModelWrapper>(SchoolSubjectModelWrapper(
        state.teachingUnits, state.currentSemesterIndex));
    emit(state.copyWith(status: TomussStatus.updated));
  }
}
