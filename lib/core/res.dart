import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

part 'generated/res.g.dart';

class Res {
  static const Duration animationDuration = Duration(milliseconds: 300);
  static final double bottomNavBarItemWidth = 100.w / 5;
  static final double bottomNavBarHeight = 10.h;
  static bool mock = false;
  static const String corsProxy = "https://192.168.220.102:3000/";
}

@HiveType(typeId: 18)
enum Functionalities {
  @HiveField(0)
  tomuss,
  @HiveField(1)
  agenda,
  @HiveField(2)
  mail,
  @HiveField(3)
  map,
  @HiveField(4)
  izly,
  @HiveField(5)
  settings,
}
