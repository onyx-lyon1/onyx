part of 'agenda_config_cubit.dart';

enum AgendaConfigStatus {
  initial,
  loading,
  loaded,
  choosed,
  searchResult,
  error
}

class AgendaConfigState {
  final AgendaConfigStatus status;
  final List<DirModel> dirs;
  final String error;
  final List<DirModel> expandedDirs;
  final List<int> choosedIds;

  AgendaConfigState({
    required this.status,
    required this.dirs,
    required this.error,
    this.choosedIds = const [],
    this.expandedDirs = const [],
  });

  AgendaConfigState copyWith({
    AgendaConfigStatus? status,
    List<DirModel>? dirs,
    String? error,
    List<int>? choosedIds,
    List<DirModel>? expandedDirs,
  }) {
    return AgendaConfigState(
      status: status ?? this.status,
      dirs: dirs ?? this.dirs,
      error: error ?? this.error,
      choosedIds: choosedIds ?? this.choosedIds,
      expandedDirs: expandedDirs ?? this.expandedDirs,
    );
  }

  @override
  String toString() {
    return 'AgendaConfigState{status: $status, dirs: $dirs, error: $error, expandedIds: $expandedDirs, choosedId: $choosedIds}';
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
          choosedIds == other.choosedIds;

  @override
  int get hashCode =>
      status.hashCode ^
      dirs.hashCode ^
      error.hashCode ^
      expandedDirs.hashCode ^
      choosedIds.hashCode;
}
