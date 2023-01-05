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
    emit(state.copyWith(status: TomussStatus.loading));
    List<SchoolSubjectModel> teachingUnits = [];
    List<SemesterModel> semesters = [];

    SemesterModelWrapper? semesterModelWrapper =
        await CacheService.get<SemesterModelWrapper>();
    if (semesterModelWrapper != null) {
      semestreIndex ??= semesterModelWrapper.currentSemesterIndex;
    }
    if (cache) {
      teachingUnits = await compute(
          TomussLogic.getTeachingUnitsCache,
          GetCacheDataPass((await getApplicationDocumentsDirectory()).path,
              semestreIndex ?? 0));
      emit(state.copyWith(
        status: TomussStatus.cacheReady,
        teachingUnits: teachingUnits,
        semesters: semesterModelWrapper?.semesters ?? [],
        currentSemesterIndex: semestreIndex ?? 0,
      ));
    }
    if (dartus != null) {
      try {
        semesters = (await TomussLogic.getSemesters(dartus))
            .map((e) => SemesterModel.fromSemester(e))
            .toList();
        semestreIndex ??= semesters
            .indexWhere((element) => element.url == Dartus.currentSemester());
        teachingUnits = await TomussLogic.getGrades(
            dartus: dartus,
            semester: semesters[semestreIndex],
            semestreIndex: semestreIndex);
      } catch (e) {
        if (kDebugMode) {
          print("Error while loading grades: $e");
        }
        emit(TomussState(status: TomussStatus.error));
        return;
      }

      teachingUnits.sort((a, b) => a.name.compareTo(b.name));
      print("semesterIndex: $semestreIndex");
      CacheService.set<SchoolSubjectModelWrapper>(
          SchoolSubjectModelWrapper(teachingUnits, semestreIndex),
          index: semestreIndex);
      CacheService.set<SemesterModelWrapper>(
          SemesterModelWrapper(semesters, currentSemesterIndex: semestreIndex));
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
