import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/functionalities/grades_backend/grades_backend.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';

part 'grades2_state.dart';

class GradesCubit extends Cubit<GradesState> {
  GradesCubit() : super(GradesState(status: GradesStatus.initial));

  Future<void> load({required Dartus dartus, bool cache=true}) async {
    emit(GradesState(status: GradesStatus.loading));
    List<TeachingUnitModel> teachingUnits = [];
    if (cache) {
      if (await CacheService.exist<TeachingUnitModelWrapper>()) {
        teachingUnits = (await CacheService.get<TeachingUnitModelWrapper>())!
            .teachingUnitModels;
        emit(GradesState(status: GradesStatus.cacheReady, teachingUnits: teachingUnits));
      }
    }
    try {
      teachingUnits = await GradesBackend.getGrades(dartus: dartus);
    } catch (e) {
      if (kDebugMode) {
        print("Error while loading grades: $e");
      }
      emit(GradesState(status: GradesStatus.error));
      return;
    }
    CacheService.set<TeachingUnitModelWrapper>(
        TeachingUnitModelWrapper(teachingUnits));
    emit(GradesState(status: GradesStatus.ready, teachingUnits: teachingUnits));
  }
}



