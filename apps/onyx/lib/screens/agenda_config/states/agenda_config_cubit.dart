import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';

part 'agenda_config_state.dart';

class AgendaConfigCubit extends Cubit<AgendaConfigState> {
  final Function(List<int> backIndexs) onBack;
  final Lyon1AgendaClient client;
  List<AgendaResource> categories = [];

  AgendaConfigCubit({required this.onBack, required this.client})
      : super(AgendaConfigState(
            categories: [], error: '', status: AgendaConfigStatus.initial));

  void loadResources() async {
    emit(state.copyWith(status: AgendaConfigStatus.loading));

    if (!(await client.isLoggedIn())) {
      emit(state.copyWith(status: AgendaConfigStatus.connecting));
      try {
        await client.login();
      } catch (e) {
        emit(state.copyWith(
            status: AgendaConfigStatus.error, error: e.toString()));
        return;
      }
    }

    try {
      categories = await client.getResources;
      emit(state.copyWith(
        status: AgendaConfigStatus.loaded,
        categories: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: AgendaConfigStatus.error, error: e.toString()));
    }
  }

  void expandAgenda(AgendaResource id, AgendaResource parent) {
    List<AgendaResource> expandedAgendas = List.from(state.expandedResources);
    int indexOfParent = expandedAgendas.indexOf(parent);
    if (indexOfParent != -1) {
      expandedAgendas.removeRange(indexOfParent + 1, expandedAgendas.length);
    } else {
      expandedAgendas = [];
    }
    expandedAgendas.add(id);

    emit(state.copyWith(expandedResources: expandedAgendas));
  }

  void collapseResource(AgendaResource id) {
    List<AgendaResource> expandedAgendas = List.from(state.expandedResources);
    expandedAgendas.remove(id);
    emit(state.copyWith(expandedResources: expandedAgendas));
  }

  void unSearch() {
    emit(state.copyWith(
      status: AgendaConfigStatus.loaded,
      categories: categories,
      expandedResources: [],
    ));
  }

  void search(String query) async {
    if (query.isEmpty) {
      unSearch();
      return;
    }
    List<AgendaResource> foundedDirs = [];
    for (var dir = 0; dir < categories.length; dir++) {
      if (categories[dir].name.toLowerCase().contains(query.toLowerCase())) {
        foundedDirs.add(categories[dir]);
      } else {
        subSearch(categories[dir], query, foundedDirs);
      }
    }
    foundedDirs = foundedDirs.reversed.toList();
    emit(state.copyWith(
        expandedResources: [],
        categories: foundedDirs,
        status: AgendaConfigStatus.searchResult));
  }

  void subSearch(
      AgendaResource dir, String query, List<AgendaResource> dirs) async {
    if (dir.children != null) {
      for (int directory = 0; directory < dir.children!.length; directory++) {
        if (dir.children![directory].name
            .replaceAll("${dir.name}.", "")
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dirs.add(dir.children![directory]);
        }
        subSearch(dir.children![directory], query, dirs);
      }
    }
  }

  void toggleChooseDir(AgendaResource dir, {bool collapse = true}) {
    if (collapse) {
      //remove all expanded dirs after this dir
      bool found = false;
      for (var i = 0; i < state.expandedResources.length && !found; i++) {
        if (state.expandedResources[i].children?.contains(dir) ?? false) {
          found = true;
          for (var j = i + 1; j < state.expandedResources.length; j++) {
            collapseResource(state.expandedResources[j]);
          }
        }
      }
      if (!found) {
        for (var i = 0; i < state.expandedResources.length; i++) {
          collapseResource(state.expandedResources[i]);
        }
      }
    }
    List<int> choosedIds = List.from(state.choosedIds);
    if (choosedIds.contains(dir.id)) {
      choosedIds.remove(dir.id);
      emit(state.copyWith(
          choosedIds: choosedIds, status: AgendaConfigStatus.choosed));
    } else {
      emit(state.copyWith(
          choosedIds: state.choosedIds + [dir.id!],
          status: AgendaConfigStatus.choosed));
    }
  }

  void resetCubit() {
    emit(AgendaConfigState(
        categories: [], error: '', status: AgendaConfigStatus.initial));
  }
}
