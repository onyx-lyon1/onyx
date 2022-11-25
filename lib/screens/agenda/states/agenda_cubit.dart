import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:oloid2/core/cache_service.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';

part 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaState> {
  Lyon1Agenda? _agendaClient;

  AgendaCubit()
      : super(AgendaState(
            status: AgendaStatus.initial,
            wantedDate: DateTime.now(),
            dayModels: []));

  Future<void> load(
      {required Dartus dartus,
      required SettingsModel settings,
      bool cache = true}) async {
    emit(state.copyWith(status: AgendaStatus.loading));
    if (cache) {
      compute((_) async {
        if (await CacheService.exist<DayModelWrapper>()) {
          state.dayModels =
              (await CacheService.get<DayModelWrapper>())!.dayModels;
          emit(state.copyWith(
              status: AgendaStatus.cacheReady, dayModels: state.dayModels));
        }
      }, null);
    }
    _agendaClient = Lyon1Agenda.useAuthentication(dartus.authentication);
    try {
      state.dayModels = await AgendaLogic.load(
          agendaClient: _agendaClient!, settings: settings);
    } catch (e) {
      emit(state.copyWith(status: AgendaStatus.error));
      return;
    }
    CacheService.set<DayModelWrapper>(
        DayModelWrapper(state.dayModels)); //await à definir
    emit(
        state.copyWith(status: AgendaStatus.ready, dayModels: state.dayModels));
  }

  void updateDisplayedDate(
      {required DateTime date, required bool fromPageController}) {
    state.wantedDate = date;
    emit(state.copyWith(
        status: AgendaStatus.dateUpdated,
        wantedDate: state.wantedDate,
        dateUpdateFromPageController: fromPageController));
  }
}
