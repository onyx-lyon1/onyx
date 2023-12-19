import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/search/search_service.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';

part 'agenda_config_state.dart';

class AgendaConfigCubit extends Cubit<AgendaConfigState> {
  final Function(List<int> backIndexs) onBack;
  List<DirModel> dirs = [];

  AgendaConfigCubit({required this.onBack})
      : super(AgendaConfigState(
            dirs: [], error: '', status: AgendaConfigStatus.initial));

  void loadDirs() async {
    emit(state.copyWith(status: AgendaConfigStatus.loading));
    try {
      dirs = await compute(AgendaConfigLogic.loadDirs, (
        encryptedData: await rootBundle.loadString(Res.agendaIdsPath),
        key: await rootBundle.loadString(Res.keyPath),
        iv: await rootBundle.loadString(Res.ivPath),
        mock: Res.mock,
      ));
      emit(state.copyWith(status: AgendaConfigStatus.loaded, dirs: dirs));
    } catch (e) {
      emit(state.copyWith(
          status: AgendaConfigStatus.error, error: e.toString()));
    }
  }

  void expandDir(DirModel id, DirModel parent) {
    List<DirModel> expandedDirs = List.from(state.expandedDirs);
    int indexOfParent = expandedDirs.indexOf(parent);
    if (indexOfParent != -1) {
      expandedDirs.removeRange(indexOfParent + 1, expandedDirs.length);
    } else {
      expandedDirs = [];
    }
    expandedDirs.add(id);

    emit(state.copyWith(expandedDirs: expandedDirs));
  }

  void collapseDir(DirModel id) {
    List<DirModel> expandedDirs = List.from(state.expandedDirs);
    expandedDirs.remove(id);
    emit(state.copyWith(expandedDirs: expandedDirs));
  }

  void unSearch() {
    emit(state.copyWith(
        status: AgendaConfigStatus.loaded, dirs: dirs, expandedDirs: []));
  }

  void search(String query) {
    if (query.isEmpty) {
      unSearch();
      return;
    }
    List<DirModel> foundedDirs = [];
    for (var dir = 0; dir < dirs.length; dir++) {
      if (SearchService.isMatch(query, dirs[dir].name)) {
        foundedDirs.add(dirs[dir]);
      } else {
        subSearch(dirs[dir], query, foundedDirs);
      }
    }
    foundedDirs = foundedDirs.reversed.toList();
    emit(state.copyWith(
        expandedDirs: [],
        dirs: foundedDirs,
        status: AgendaConfigStatus.searchResult));
  }

  void subSearch(DirModel dir, String query, List<DirModel> dirs) {
    if (dir.children != null) {
      for (int directory = 0; directory < dir.children!.length; directory++) {
        if (SearchService.isMatch(query,
            dir.children![directory].name.replaceAll("${dir.name}.", ""))) {
          dirs.add(dir.children![directory]);
        }
        subSearch(dir.children![directory], query, dirs);
      }
    }
  }

  void toggleChooseDir(DirModel dir, {bool collapse = true}) {
    if (collapse) {
      //remove all expanded dirs after this dir
      bool found = false;
      for (var i = 0; i < state.expandedDirs.length && !found; i++) {
        if (state.expandedDirs[i].children?.contains(dir) ?? false) {
          found = true;
          for (var j = i + 1; j < state.expandedDirs.length; j++) {
            collapseDir(state.expandedDirs[j]);
          }
        }
      }
      if (!found) {
        for (var i = 0; i < state.expandedDirs.length; i++) {
          collapseDir(state.expandedDirs[i]);
        }
      }
    }
    List<int> choosedIds = List.from(state.choosedIds);
    if (choosedIds.contains(dir.identifier)) {
      choosedIds.remove(dir.identifier);
      emit(state.copyWith(
          choosedIds: choosedIds, status: AgendaConfigStatus.choosed));
    } else {
      emit(state.copyWith(
          choosedIds: state.choosedIds + [dir.identifier],
          status: AgendaConfigStatus.choosed));
    }
  }

  void resetCubit() {
    emit(AgendaConfigState(
        dirs: [], error: '', status: AgendaConfigStatus.initial));
  }
}
