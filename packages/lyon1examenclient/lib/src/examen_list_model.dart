import 'package:hive/hive.dart';
import 'package:lyon1examenclient/src/examen_model.dart';

part 'examen_list_model.g.dart';

@HiveType(typeId: 49)
class ExamenListModel {
  @HiveField(0)
  List<ExamenModel> examens;

  ExamenListModel(this.examens);
}
