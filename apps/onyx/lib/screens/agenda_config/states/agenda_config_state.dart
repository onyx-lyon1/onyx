part of 'agenda_config_cubit.dart';

enum AgendaConfigStatus { initial, loading, loaded, choosed, searchResult,  error }

class AgendaConfigState {
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

  AgendaConfigState copyWith({
    AgendaConfigStatus? status,
    List<DirModel>? dirs,
    String? error,
    int? choosedId,
    List<DirModel>? expandedDirs,
  }) {
    return AgendaConfigState(
      status: status ?? this.status,
      dirs: dirs ?? this.dirs,
      error: error ?? this.error,
      choosedId: choosedId ?? this.choosedId,
      expandedDirs: expandedDirs ?? this.expandedDirs,
    );
  }

  @override
  String toString() {
    return 'AgendaConfigState{status: $status, dirs: $dirs, error: $error, expandedIds: $expandedDirs, choosedId: $choosedId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaConfigState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          dirs == other.dirs &&
          error == other.error &&
          expandedDirs == other.expandedDirs &&
          choosedId == other.choosedId;

  @override
  int get hashCode =>
      status.hashCode ^
      dirs.hashCode ^
      error.hashCode ^
      expandedDirs.hashCode ^
      choosedId.hashCode;
}
