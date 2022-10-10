// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartus/tomuss.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:oloid2/model/day_model.dart';
import 'package:oloid2/model/event_model.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/others/cache_service.dart';

part 'agenda_event.dart';

part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  Lyon1Agenda? agendaClient;
  List<DayModel> dayModels = [];

  AgendaBloc() : super(AgendaInitial()) {
    on<AgendaEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AgendaLoad>(load);
  }

  Future<void> load(AgendaLoad event, Emitter emit) async {
    if (await CacheService.exist<DayModelWrapper>()) {
      dayModels = (await CacheService.get<DayModelWrapper>())!.dayModels;
      emit(AgendaReady());
    }
    late Option<Agenda> agendaOpt;
    agendaClient = Lyon1Agenda.useAuthentication(event.dartus.authentication);
    try {
      agendaOpt = await agendaClient!.getAgenda(
          url:
              (event.settings.fetchAgendaAuto) ? "" : event.settings.agendaURL);
      if (agendaOpt.isNone()) {
        emit(AgendaError());
        if (kDebugMode) {
          print("agenda is none");
        }
        return;
      }
    } catch (e) {
      emit(AgendaError());
      if (kDebugMode) {
        print("error: $e");
      }
      return;
    }
    final Agenda agenda = agendaOpt.toNullable() ?? Agenda.empty();

    List<DayModel> tmpDayModels = [];

    for (final Event e in agenda.events) {
      EventModel event = EventModel(
          summary: "summary",
          description: e.name,
          end: e.end.toLocal(),
          eventLastModified: e.lastModified.toLocal(),
          location: e.location,
          start: e.start.toLocal(),
          teacher: e.teacher);

      int index = tmpDayModels.indexWhere((element) =>
          element.date.toLocal().day == e.start.toLocal().day &&
          element.date.toLocal().month == e.start.toLocal().month &&
          element.date.toLocal().year == e.start.toLocal().year);

      if (index != -1) {
        tmpDayModels[index].events.add(event);
      } else {
        tmpDayModels.add(DayModel(
            DateTime(e.start.toLocal().year, e.start.toLocal().month,
                e.start.toLocal().day),
            [event]));
      }
    }
    for (var i in tmpDayModels) {
      List<EventModel> events = [];
      for (var e in i.events) {
        if (events.indexWhere((element) => element.start == e.start) == -1) {
          events.add(e);
        }
      }
      i.events = events;
      i.events.sort((a, b) => a.start.compareTo(b.start));
    }
    tmpDayModels.sort((a, b) => a.date.compareTo(b.date));
    DateTime first = tmpDayModels.first.date;
    DateTime last = tmpDayModels.last.date;
    for (DateTime i = first;
        i.isBefore(last);
        i = i.add(const Duration(days: 1))) {
      int index = tmpDayModels.indexWhere((element) =>
          element.date.toLocal().day == i.day &&
          element.date.toLocal().month == i.month &&
          element.date.toLocal().year == i.year);
      if (index == -1) {
        tmpDayModels.insert(
            tmpDayModels.indexWhere((element) =>
                    element.date.toLocal().day ==
                        i.subtract(const Duration(days: 1)).day &&
                    element.date.toLocal().month ==
                        i.subtract(const Duration(days: 1)).month &&
                    element.date.toLocal().year ==
                        i.subtract(const Duration(days: 1)).year) +
                1,
            DayModel(i, []));
      }
    }
    dayModels = tmpDayModels;
    CacheService.set<DayModelWrapper>(
        DayModelWrapper(dayModels)); //await à definir
    emit(AgendaReady());
    return;
  }
}
