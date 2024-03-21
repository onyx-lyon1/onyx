import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/logic/agenda_logic.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:path_provider/path_provider.dart';

part 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaState> {
  Lyon1AgendaClient? _agendaClient;

  PageController miniCalendarScrollController = PageController();
  List<PageController> horizontalScrollController =
      List.generate(3, (index) => PageController());
  final PageController verticalScrollController = PageController();
  bool blockMiniCalendar = false;
  bool blockHorizontalScroll = false;

  AgendaCubit()
      : super(AgendaState(
            status: AgendaStatus.initial,
            wantedDate: 0,
            realDays: [],
            settingsModel: const SettingsModel()));

  void load(
      {required Lyon1CasClient? lyon1Cas,
      required SettingsModel settings,
      bool cache = true,
      bool fromUser = false}) async {
    emit(state.copyWith(status: AgendaStatus.loading, settingsModel: settings));
    if (cache && !Res.mock && !kIsWeb) {
      List<Day> realDays = await compute(
        AgendaLogic.getCache,
        (await getApplicationDocumentsDirectory()).path,
      );
      emit(state.copyWith(
          status: AgendaStatus.cacheReady,
          realDays: realDays,
          wantedDate: realDays
              .indexWhere((element) => element.date.isSameDay(DateTime.now()))
              .clamp(0, state.realDays.length),
          settingsModel: settings));
      if (!fromUser) {
        goToday(
            fromMiniCalendar: false,
            fromHorizontalScroll: false,
            settings: settings);
      }
    }
    if (!settings.fetchAgendaAuto && settings.agendaIds.isEmpty) {
      emit(state.copyWith(
          status: AgendaStatus.haveToChooseManualy, settingsModel: settings));
      return;
    }
    if (lyon1Cas != null && lyon1Cas.isAuthenticated) {
      _agendaClient = Lyon1AgendaClient.useLyon1Cas(lyon1Cas);
      List<int> ids = settings.agendaIds;
      try {
        if (settings.fetchAgendaAuto) {
          ids = (await _agendaClient!.getAgendaIds);
        }
        List<Day> realDays = await AgendaLogic.load(
            agendaClient: _agendaClient!, settings: settings, ids: ids);

        CacheService.set<Agenda>(Agenda(realDays));
        emit(
          state.copyWith(
            status: AgendaStatus.ready,
            realDays: realDays,
            agendaIds: ids,
            settingsModel: settings,
          ),
        );
        if (state.status != AgendaStatus.cacheReady && !fromUser) {
          goToday(
              fromMiniCalendar: false,
              fromHorizontalScroll: false,
              settings: settings);
        }
        await addRestaurant();
      } catch (e) {
        if (e.toString().contains("AutoIdException")) {
          emit(state.copyWith(
              status: AgendaStatus.haveToChooseManualy,
              settingsModel: settings));
        } else {
          Res.logger.e(e);
          emit(state.copyWith(
              status: AgendaStatus.error, settingsModel: settings));
        }
        return;
      }
    }
  }

  void addExternalEvent(List<Event> events) {
    emit(state.copyWith(
        examEvents: state.examEvents + events,
        settingsModel: const SettingsModel()));
  }

  void removeExternalEvent(List<Event> events) {
    emit(state.copyWith(
      examEvents: state.examEvents
          .where((element) => !events.contains(element))
          .toList(),
      settingsModel: const SettingsModel(),
    ));
  }

  void clearExternalEvent() {
    emit(state.copyWith(examEvents: [], settingsModel: const SettingsModel()));
  }

  Future<void> addRestaurant() async {
    List<Day> days = await AgendaLogic.addRestaurant(List.from(state.realDays));
    emit(state.copyWith(
        status: AgendaStatus.ready,
        realDays: days,
        settingsModel: const SettingsModel()));
  }

  void updateDisplayedDate(
      {required int wantedDate,
      required bool fromMiniCalendar,
      required bool fromHorizontalScroll,
      required SettingsModel settings}) {
    if (!fromHorizontalScroll) {
      if (!blockMiniCalendar || !fromMiniCalendar) {
        blockHorizontalScroll = true;
        Future.delayed(
            Res.animationDuration, () => blockHorizontalScroll = false);
        if (horizontalScrollController[0].hasClients) {
          horizontalScrollController[0].animateToPage(
            wantedDate,
            duration: Res.animationDuration,
            curve: Curves.easeInOut,
          );
        }
        if (horizontalScrollController[1].hasClients) {
          horizontalScrollController[1].animateToPage(
            wantedDate ~/ settings.agendaWeekLength,
            duration: Res.animationDuration,
            curve: Curves.easeInOut,
          );
        }
      }
    }
    if (!fromMiniCalendar) {
      if (!blockHorizontalScroll || !fromHorizontalScroll) {
        blockMiniCalendar = true;
        Future.delayed(Res.animationDuration, () => blockMiniCalendar = false);
        if (miniCalendarScrollController.hasClients) {
          miniCalendarScrollController.animateToPage(
            wantedDate ~/ settings.agendaWeekLength,
            duration: Res.animationDuration,
            curve: Curves.easeInOut,
          );
        }
      }
    }

    emit(
      state.copyWith(
        status: AgendaStatus.dateUpdated,
        wantedDate: wantedDate,
        settingsModel: settings,
      ),
    );
  }

  void goToday(
      {required bool fromMiniCalendar,
      required bool fromHorizontalScroll,
      required SettingsModel settings}) {
    int index = state.getDayIndex(date: DateTime.now(), settings: settings);
    if (index != -1) {
      updateDisplayedDate(
          wantedDate: index,
          fromMiniCalendar: fromMiniCalendar,
          fromHorizontalScroll: fromHorizontalScroll,
          settings: settings);
    }
  }

  void resetCubit() {
    emit(AgendaState(
        status: AgendaStatus.initial,
        wantedDate: 0,
        realDays: [],
        settingsModel: const SettingsModel()));
  }
}
