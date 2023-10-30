part of 'agenda_config_cubit.dart';
@MappableEnum()
enum AgendaConfigStatus {
  @MappableValue(000)
  initial,
  @MappableValue(100)
  loading,
  @MappableValue(200)
  loaded,
  @MappableValue(300)
  choosed,
  @MappableValue(400)
  searchResult,
  @MappableValue(500)
  error
}
@MappableClass()
class AgendaConfigState with AgendaConfigStateMappable{
  final AgendaConfigStatus status;
  final List<DirModel> dirs;
  final String error;
  final List<DirModel> expandedDirs;
  final int choosedId;

  AgendaConfigState({
    required this.status,
    required this.dirs,
    required this.error,
    required this.choosedId,
    this.expandedDirs = const [],
  });
}
