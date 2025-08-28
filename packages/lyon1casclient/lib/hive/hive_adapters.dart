import 'package:hive_ce/hive.dart';
import 'package:lyon1casclient/src/credential.dart';

part 'generated/hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Credential>(),
])

class HiveAdapters {}
