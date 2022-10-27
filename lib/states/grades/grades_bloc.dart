// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

// ignore: implementation_imports
import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/functionalities/grades_backend/grades_backend.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';

part 'grades_event.dart';

part 'grades_state.dart';

class GradesBloc extends Bloc<GradesEvent, GradesState> {
  List<TeachingUnitModel> teachingUnits = [];

  GradesBloc() : super(GradesInitial()) {
    on<GradesEvent>((event, emit) {});
    on<GradesLoad>(load);
  }

  Future<void> load(GradesLoad event, Emitter<GradesState> emit) async {
    emit(GradesLoading());
    if (event.cache) {
      if (await CacheService.exist<TeachingUnitModelWrapper>()) {
        teachingUnits = (await CacheService.get<TeachingUnitModelWrapper>())!
            .teachingUnitModels;
        emit(GradesReady());
      }
    }
    try {
      teachingUnits = await GradesBackend.getGrades(dartus: event.dartus);
    } catch (e) {
      print("Error while loading grades: $e");
      emit(GradesError());
      return;
    }
    CacheService.set<TeachingUnitModelWrapper>(
        TeachingUnitModelWrapper(teachingUnits)); //await à definir
    emit(GradesReady());
  }
}
