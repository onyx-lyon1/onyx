import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/logic/agenda_logic.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:path_provider/path_provider.dart';

part 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaState> {
  Lyon1AgendaClient? _agendaClient;
  bool animating = false;

  AgendaCubit()
      : super(AgendaState(
            status: AgendaStatus.initial,
            wantedDate: DateTime.now(),
            realDays: []));

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
          status: AgendaStatus.cacheReady, realDays: state.realDays));
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
      emit(
          state.copyWith(status: AgendaStatus.ready, realDays: state.realDays));
      await addRestaurant();
    }
  }

  Future<void> addRestaurant() async {
    await AgendaLogic.addRestaurant(List.from(state.realDays));
    emit(state.copyWith(status: AgendaStatus.ready, realDays: state.realDays));
  }

  void updateDisplayedDate({required DateTime date}) {
    emit(
      state.copyWith(
        status: AgendaStatus.dateUpdated,
        wantedDate: date,
      ),
    );
  }

  void updateDayCount(int dayCount) {
    emit(
      state.copyWith(
        status: AgendaStatus.updateDayCount,
        dayCount: dayCount,
      ),
    );
  }

  void resetCubit() {
    emit(AgendaState(
        status: AgendaStatus.initial,
        wantedDate: DateTime.now(),
        realDays: []));
  }
}
