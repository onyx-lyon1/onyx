import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';

part 'tomuss_state.dart';

class TomussCubit extends Cubit<TomussState> {
  TomussCubit() : super(TomussState(status: TomussStatus.initial));

  Future<void> load({required Dartus? dartus, bool cache = true}) async {
    emit(TomussState(status: TomussStatus.loading));
    List<SchoolSubjectModel> teachingUnits = [];
    if (cache) {
      teachingUnits = await compute(TomussLogic.getCache,
          (await getApplicationDocumentsDirectory()).path);
      emit(TomussState(
          status: TomussStatus.cacheReady, teachingUnits: teachingUnits));
    }
    if (dartus != null) {
      try {
        teachingUnits = await TomussLogic.getGrades(dartus: dartus);
      } catch (e) {
        if (kDebugMode) {
          print("Error while loading grades: $e");
        }
        emit(TomussState(status: TomussStatus.error));
        return;
      }
      teachingUnits.sort((a, b) => a.name.compareTo(b.name));
      CacheService.set<SchoolSubjectModelWrapper>(
          SchoolSubjectModelWrapper(teachingUnits));
      emit(TomussState(
          status: TomussStatus.ready, teachingUnits: teachingUnits));
    }
  }
}
