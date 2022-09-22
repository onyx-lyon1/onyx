part of 'agenda_bloc.dart';



@immutable
abstract class AgendaEvent {}
class AgendaLoad extends AgendaEvent {
final Dartus dartus;
final SettingsModel settings;
  AgendaLoad(this.dartus, this.settings);
}
