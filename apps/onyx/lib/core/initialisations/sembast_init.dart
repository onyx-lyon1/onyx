import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> initSembastDb() async {
  final dir = await getApplicationDocumentsDirectory();
  final dbPath = join(dir.path, 'onyx.db');
  final db = await databaseFactoryIo.openDatabase(dbPath);
  return db;
}
