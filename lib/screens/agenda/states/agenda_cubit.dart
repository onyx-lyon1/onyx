import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/logic/agenda_logic.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:path_provider/path_provider.dart';

part 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaState> {
  Lyon1Agenda? _agendaClient;

  AgendaCubit()
      : super(AgendaState(
            status: AgendaStatus.initial,
            wantedDate: DateTime.now(),
            days: []));

  Future<void> load(
      {required Dartus? dartus,
      required SettingsModel settings,
      bool cache = true}) async {
    emit(state.copyWith(status: AgendaStatus.loading));
    if (cache && !Res.mock) {
      state.days = await compute(
        AgendaLogic.getCache,
        (await getApplicationDocumentsDirectory()).path,
      );
      emit(state.copyWith(status: AgendaStatus.cacheReady, days: state.days));
    }
    if (!settings.fetchAgendaAuto && settings.agendaId == null) {
      emit(state.copyWith(status: AgendaStatus.haveToChooseManualy));
      return;
    }
    if (dartus != null) {
      _agendaClient = Lyon1Agenda.useAuthentication(dartus.authentication);
      try {
        state.days = await AgendaLogic.load(
            agendaClient: _agendaClient!, settings: settings);
      } catch (e) {
        emit(state.copyWith(status: AgendaStatus.error));
        return;
      }
      CacheService.set<Agenda>(Agenda(state.days)); //await à definir
      emit(state.copyWith(status: AgendaStatus.ready, days: state.days));
    }
  }

  void updateDisplayedDate(
      {required DateTime date, required bool fromPageController}) {
    emit(state.copyWith(
        status: AgendaStatus.dateUpdated,
        wantedDate: date,
        dateUpdateFromPageController: fromPageController));
  }

  void resetCubit() {
    emit(AgendaState(
        status: AgendaStatus.initial, wantedDate: DateTime.now(), days: []));
  }
}
