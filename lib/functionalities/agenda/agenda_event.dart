part of 'agenda_bloc.dart';



@immutable
abstract class AgendaEvent {}
class AgendaLoad extends AgendaEvent {
final Dartus dartus;
final SettingsModel settings;
final bool cache;
  AgendaLoad(this.dartus, this.settings,{this.cache = true});
}
