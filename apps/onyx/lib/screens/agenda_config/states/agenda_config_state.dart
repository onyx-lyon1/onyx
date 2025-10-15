part of 'agenda_config_cubit.dart';

enum AgendaConfigStatus {
  initial,
  loading,
  loaded,
  chosen,
  searchResult,
  connecting,
  error
}

class AgendaConfigState {
  final AgendaConfigStatus status;
  final List<AgendaResource> categories;
  final String error;
  final List<AgendaResource> expandedResources;
  final List<int> chosenIds;

  AgendaConfigState({
    required this.status,
    required this.categories,
    required this.error,
    this.chosenIds = const [],
    this.expandedResources = const [],
  });

  AgendaConfigState copyWith({
    AgendaConfigStatus? status,
    List<AgendaResource>? categories,
    String? error,
    List<int>? chosenIds,
    List<AgendaResource>? expandedResources,
  }) {
    return AgendaConfigState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error ?? this.error,
      chosenIds: chosenIds ?? this.chosenIds,
      expandedResources: expandedResources ?? this.expandedResources,
    );
  }

  @override
  String toString() {
    return 'AgendaConfigState{status: $status, categories: $categories, error: $error, expandedResources: $expandedResources, chosenIds: $chosenIds}';
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
          chosenIds == other.chosenIds;

  @override
  int get hashCode =>
      status.hashCode ^
      categories.hashCode ^
      error.hashCode ^
      expandedResources.hashCode ^
      chosenIds.hashCode;
}
