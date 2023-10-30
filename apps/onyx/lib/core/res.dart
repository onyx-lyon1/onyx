import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:logger/logger.dart';

part 'res.mapper.dart';

class Res {
  static Duration get animationDuration => const Duration(milliseconds: 300);

  static double get bottomNavBarItemWidth => 20.w;

  static double get bottomNavBarHeight =>
      (Device.orientation == Orientation.portrait) ? 10.h : 5.w;

  static double get topBarHeight => (Device.orientation == Orientation.portrait)
      ? bottomNavBarHeight
      : bottomNavBarHeight * 1.5;

  static bool get isPhone {
    return ((isPortrait && Device.width <= 599) ||
        (isLandscape && Device.height <= 599));
  }

  static bool get isWide => Device.width >= 600;

  static bool get isPortrait => Device.orientation == Orientation.portrait;

  static bool get isLandscape => Device.orientation == Orientation.landscape;

  static bool mock = false;
  static const String corsProxy = "https://192.168.220.102:3000/";
  static const String agendaIdsIvPath = "assets/iv.txt";
  static const String agendaIdsKeyPath = "assets/key.txt";
  static const String agendaIdsPath = "assets/agenda_ids.json.enc";

  static const Duration agendaDayStart = Duration(hours: 6);
  static const Duration agendaDayEnd = Duration(hours: 22);
  static const Duration agendaDayDuration = Duration(
      hours: 16); // be careful to change this value accordingly to the previous
// 22 - 6 = 16

  static final logger = Logger(
    level: (kDebugMode) ? Level.all : Level.fatal,
  );
}

@MappableEnum()
enum Functionalities {
  @MappableValue(000)
  tomuss,
  @MappableValue(100)
  agenda,
  @MappableValue(200)
  mail,
  @MappableValue(300)
  map,
  @MappableValue(400)
  izly,
  @MappableValue(500)
  settings,
}
