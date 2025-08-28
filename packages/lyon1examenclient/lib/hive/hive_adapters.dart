import 'package:hive_ce/hive.dart';
import 'package:lyon1examenclient/src/examen_list_model.dart';
import 'package:lyon1examenclient/src/examen_model.dart';

@GenerateAdapters([
  AdapterSpec<ExamenModel>(),
  AdapterSpec<ExamenListModel>(),
])
part 'hive_adapters.g.dart';
