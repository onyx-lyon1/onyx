import 'package:hive/hive.dart';

part 'generated/year.g.dart';

@HiveType(typeId: 47)
enum Year {
  @HiveField(0)
  first,
  @HiveField(1)
  second,
}
