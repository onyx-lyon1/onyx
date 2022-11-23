import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/functionalities/settings_backend/settings_backend.dart';
import 'package:oloid2/model/settings.dart';
import 'package:workmanager/workmanager.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(settings: SettingsModel(), status: SettingsStatus.initial));

  Future<void> reset() async {
    await SettingsBackend.reset();
    emit(state.copyWith(status: SettingsStatus.ready, settings: SettingsModel()));
  }

  Future<void> load() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try{
      emit(state.copyWith(status: SettingsStatus.ready, settings: await SettingsBackend.load()));
    }catch(e){
       emit(state.copyWith(status: SettingsStatus.error, settings: SettingsModel()));
    }
    if (!(state.settings.calendarUpdateNotification &&
        state.settings.newMailNotification &&
        state.settings.newGradeNotification)) {
      Workmanager().cancelByUniqueName("updateChecking");
    }
  }

  Future<void> modify({required SettingsModel settings}) async {
    await SettingsBackend.modify(settings: settings);
    emit(state.copyWith(status: SettingsStatus.ready, settings: settings));
  }
}
