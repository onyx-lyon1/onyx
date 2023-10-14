import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/search/search_service.dart';
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
      dirs = await compute(AgendaConfigLogic.loadDirs, (
        encryptedData: await rootBundle.loadString(Res.agendaIdsPath),
        key: await rootBundle.loadString(Res.agendaIdsKeyPath),
        iv: await rootBundle.loadString(Res.agendaIdsIvPath),
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
    List<DirModel> foundedDirs = [];
    for (var dir = 0; dir < dirs.length; dir++) {
      if (SearchService.isMatch(
          query,
          Uri.decodeFull(
              Uri.encodeFull(dirs[dir].name.replaceAll("\\x", "%"))))) {
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
        if (SearchService.isMatch(
            query,
            Uri.decodeFull(Uri.encodeFull(
                    dir.children![directory].name.replaceAll("\\x", "%")))
                .replaceAll(dir.name, ""))) {
          dirs.add(dir.children![directory]);
        }
        subSearch(dir.children![directory], query, dirs);
      }
    }
  }

  void chooseDir(int id) {
    onBack(id);
  }

  void resetCubit() {
    emit(AgendaConfigState(
        choosedId: 0, dirs: [], error: '', status: AgendaConfigStatus.initial));
  }
}
