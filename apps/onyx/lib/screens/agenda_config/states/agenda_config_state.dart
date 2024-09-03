part of 'agenda_config_cubit.dart';

enum AgendaConfigStatus {
  initial,
  loading,
  loaded,
  choosed,
  searchResult,
  connecting,
  error
}

class AgendaConfigState {
  final AgendaConfigStatus status;
  final List<AgendaResource> categories;
  final String error;
  final List<AgendaResource> expandedResources;
  final List<int> choosedIds;

  AgendaConfigState({
    required this.status,
    required this.categories,
    required this.error,
    this.choosedIds = const [],
    this.expandedResources = const [],
  });

  AgendaConfigState copyWith({
    AgendaConfigStatus? status,
    List<AgendaResource>? categories,
    String? error,
    List<int>? choosedIds,
    List<AgendaResource>? expandedResources,
  }) {
    return AgendaConfigState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error ?? this.error,
      choosedIds: choosedIds ?? this.choosedIds,
      expandedResources: expandedResources ?? this.expandedResources,
    );
  }

  @override
  String toString() {
    return 'AgendaConfigState{status: $status, categories: $categories, error: $error, expandedResources: $expandedResources, choosedIds: $choosedIds}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaConfigState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          categories == other.categories &&
          error == other.error &&
          expandedResources == other.expandedResources &&
          choosedIds == other.choosedIds;

  @override
  int get hashCode =>
      status.hashCode ^
      categories.hashCode ^
      error.hashCode ^
      expandedResources.hashCode ^
      choosedIds.hashCode;
}
