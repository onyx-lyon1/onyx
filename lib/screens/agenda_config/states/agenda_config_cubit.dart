import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';

part 'agenda_config_state.dart';

class AgendaConfigCubit extends Cubit<AgendaConfigState> {
  final Function(int backIndex) onBack;
  List<DirModel> dirs = [];

  AgendaConfigCubit({required this.onBack})
      : super(AgendaConfigState(
            choosedId: 0,
            dirs: [],
            error: '',
            status: AgendaConfigStatus.initial));

  void loadDirs() async {
    emit(state.copyWith(status: AgendaConfigStatus.loading));
    try {
      dirs = await compute(
          AgendaConfigLogic.loadDirs,
          LoadData(await rootBundle.loadString('assets/agenda_ids.json.enc'),
              await rootBundle.loadString('assets/key.txt')));
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
    List<DirModel> foundedDirs = [];
    for (var dir = 0; dir < state.dirs.length; dir++) {
      if (removeDiacritics(state.dirs[dir].name.toLowerCase())
          .contains(removeDiacritics(query.toLowerCase()))) {
        foundedDirs.add(state.dirs[dir]);
      } else {
        subSearch(state.dirs[dir], query, foundedDirs);
      }
    }
    foundedDirs = foundedDirs.reversed.toList();
    emit(state.copyWith(
        expandedDirs: [],
        dirs: foundedDirs,
        status: AgendaConfigStatus.searchResult));
  }

  bool subSearch(DirModel dir, String query, List<DirModel> dirs) {
    for (int directory = 0; directory < dir.children.length; directory++) {
      if (removeDiacritics(dir.children[directory].name.toLowerCase())
          .contains(removeDiacritics(query.toLowerCase()))) {
        dirs.add(dir.children[directory]);
        return true;
      } else {
        if (subSearch(dir.children[directory], query, dirs)) {
          return true;
        }
      }
    }
    return false;
  }

  void chooseDir(int id) {
    onBack(id);
  }
}
