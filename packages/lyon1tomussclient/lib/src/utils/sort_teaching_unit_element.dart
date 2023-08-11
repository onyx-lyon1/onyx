import 'package:lyon1tomussclient/src/model/model_export.dart';

extension SortTeachingUnitElement on List<TeachingUnitElement> {
  List<TeachingUnitElement> sortByPosition() {
    return this..sort((a, b) => a.position.compareTo(b.position));
  }
}
