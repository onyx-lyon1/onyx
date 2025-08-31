import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1examenclient/src/examen_model.dart';

part 'generated/examen_list_model.mapper.dart';

@MappableClass()
class ExamenListModel with ExamenListModelMappable {
  List<ExamenModel> examens;

  ExamenListModel(this.examens);
}
