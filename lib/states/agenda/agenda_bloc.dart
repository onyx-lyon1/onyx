// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:oloid2/functionalities/agenda_backend/agenda_backend.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/model/day_model.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';

part 'agenda_event.dart';

part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  Lyon1Agenda? agendaClient;
  List<DayModel> dayModels = [];
  DateTime wantedDate = DateTime.now();

  AgendaBloc() : super(AgendaInitial()) {
    on<AgendaEvent>((event, emit) {
      if (kDebugMode) {
        print("AgendaBloc: $event");
      }
    });
    on<AgendaLoad>(load);
    on<AgendaUpdateDisplayedDate>(updateDisplayedDate);
  }

  Future<void> load(AgendaLoad event, Emitter emit) async {
    emit(AgendaLoading());
    if (event.cache) {
      if (await CacheService.exist<DayModelWrapper>()) {
        dayModels = (await CacheService.get<DayModelWrapper>())!.dayModels;
        emit(AgendaReady());
      }
    }
    agendaClient = Lyon1Agenda.useAuthentication(event.dartus.authentication);
    try {
      dayModels = await AgendaBackend.load(
          agendaClient: agendaClient!, settings: event.settings);
    } catch (e) {
      emit(AgendaError());
      return;
    }
    CacheService.set<DayModelWrapper>(
        DayModelWrapper(dayModels)); //await à definir
    emit(AgendaReady());
  }

  void updateDisplayedDate(AgendaUpdateDisplayedDate event, Emitter emit) {
    wantedDate = event.date;
    emit(AgendaDateUpdated());
  }
}
