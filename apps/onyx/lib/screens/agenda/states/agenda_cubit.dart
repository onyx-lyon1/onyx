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

  final PageController miniCalendarScrollController = PageController();
  final List<PageController> horizontalScrollController =
      List.generate(3, (index) => PageController());
  final PageController verticalScrollController = PageController();
  bool blockMiniCalendar = false;
  bool blockHorizontalScroll = false;

  AgendaCubit()
      : super(AgendaState(
            status: AgendaStatus.initial, wantedDate: 0, realDays: []));

  Future<void> load(
      {required Lyon1CasClient? lyon1Cas,
      required SettingsModel settings,
      bool cache = true}) async {
    emit(state.copyWith(status: AgendaStatus.loading));
    if (cache && !Res.mock && !kIsWeb) {
      state.realDays = await compute(
        AgendaLogic.getCache,
        (await getApplicationDocumentsDirectory()).path,
      );
      emit(state.copyWith(
          status: AgendaStatus.cacheReady,
          realDays: state.realDays,
          wantedDate: state.realDays
              .indexWhere((element) => element.date
                  .shrink(3)
                  .isAtSameMomentAs(DateTime.now().shrink(3)))
              .clamp(0, state.realDays.length - 1)));
    }
    if (!settings.fetchAgendaAuto && settings.agendaId == null) {
      emit(state.copyWith(status: AgendaStatus.haveToChooseManualy));
      return;
    }
    if (lyon1Cas != null && lyon1Cas.isAuthenticated) {
      _agendaClient = Lyon1AgendaClient.useLyon1Cas(lyon1Cas);
      try {
        state.realDays = await AgendaLogic.load(
            agendaClient: _agendaClient!, settings: settings);
      } catch (e) {
        if (e.toString().contains("AutoIdException")) {
          emit(state.copyWith(status: AgendaStatus.haveToChooseManualy));
        } else {
          emit(state.copyWith(status: AgendaStatus.error));
        }
        return;
      }
      CacheService.set<Agenda>(Agenda(state.realDays));
      emit(state.copyWith(
          status: AgendaStatus.ready,
          realDays: state.realDays,
          wantedDate: state.realDays
              .indexWhere((element) => element.date
                  .shrink(3)
                  .isAtSameMomentAs(DateTime.now().shrink(3)))
              .clamp(0, state.realDays.length - 1)));
      await addRestaurant();
    }
  }

  Future<void> addRestaurant() async {
    await AgendaLogic.addRestaurant(List.from(state.realDays));
    emit(state.copyWith(status: AgendaStatus.ready, realDays: state.realDays));
  }

  void updateDisplayedDate(
      {required int wantedDate, required bool fromMiniCalendar}) {
    if (fromMiniCalendar) {
      if (!blockMiniCalendar) {
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
            wantedDate ~/ 5,
            duration: Res.animationDuration,
            curve: Curves.easeInOut,
          );
        }
      }
    } else {
      if (!blockHorizontalScroll) {
        blockMiniCalendar = true;
        Future.delayed(Res.animationDuration, () => blockMiniCalendar = false);
        if (miniCalendarScrollController.hasClients) {
          miniCalendarScrollController.animateToPage(
            wantedDate ~/ 5,
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
      ),
    );
  }

  void resetCubit() {
    emit(
        AgendaState(status: AgendaStatus.initial, wantedDate: 0, realDays: []));
  }
}
