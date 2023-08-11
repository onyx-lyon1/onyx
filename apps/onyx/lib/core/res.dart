import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

part 'generated/res.g.dart';

class Res {
  static Duration get animationDuration => const Duration(milliseconds: 300);

  static double get bottomNavBarItemWidth => 20.w;

  static double get bottomNavBarHeight =>
      (Device.orientation == Orientation.portrait) ? 10.h : 5.w;
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
