import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

extension SortTeachingUnitElement on List<TeachingUnitElement> {
  List<TeachingUnitElement> sortByPosition() {
    return this..sort((a, b) => a.position.compareTo(b.position));
  }
}
