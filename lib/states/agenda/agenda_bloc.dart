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
    for (final Event e in agenda.events) {
      // if (kDebugMode) {
      //   print(e.name);
      //   print(e.description);
      //   print("lastmodified : ${e.lastModified.toLocal()}");
      //   print("\t${e.location} | ${e.teacher}");
      //   print(
      //       "\t${e.start.toLocal().toString()} -> ${e.end.toLocal().toString()}");
      // }
      EventModel event = EventModel(
        summary: "summary",
        //e.name,
        description: e.name,
        //e.description,
        end: e.end.toLocal(),
        eventLastModified: e.lastModified.toLocal(),
        location: e.location,
        start: e.start.toLocal(),
        teacher: "teacher", //e.teacher
      );
      int index = dayModels.indexWhere((element) =>
          element.date.toLocal().day == e.start.toLocal().day &&
          element.date.toLocal().month == e.start.toLocal().month &&
          element.date.toLocal().year == e.start.toLocal().year);

      if (index != -1) {
        dayModels[index].events.add(event);
      } else {
        dayModels.add(DayModel(
            DateTime(e.start.toLocal().year, e.start.toLocal().month,
                e.start.toLocal().day),
            [event]));
      }
    }
    for (var i in dayModels) {
      List<EventModel> events = [];
      for (var e in i.events) {
        if (events.indexWhere((element) => element.start == e.start) == -1) {
          events.add(e);
        }
      }
      i.events = events;
      i.events.sort((a, b) => a.start.compareTo(b.start));
    }
    dayModels.sort((a, b) => a.date.compareTo(b.date));
    DateTime first = dayModels.first.date;
    DateTime last = dayModels.last.date;
    for (DateTime i = first;
        i.isBefore(last);
        i = i.add(const Duration(days: 1))) {
      int index = dayModels.indexWhere((element) =>
          element.date.toLocal().day == i.day &&
          element.date.toLocal().month == i.month &&
          element.date.toLocal().year == i.year);
      if (index == -1) {
        dayModels.insert(
            dayModels.indexWhere((element) =>
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

      emit(AgendaReady());
      return;

  }
}
