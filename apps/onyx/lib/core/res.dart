import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
  static const String discordUrl = "https://discord.gg/ReUKtKU523";
  static const String websiteUrl = "https://onyx-lyon1.github.io/";

  static const String ivPath = "assets/iv.txt";
  static const String keyPath = "assets/key.txt";
  static const String agendaIdsPath = "assets/agenda_ids.json.enc";

  static const String colloscopeIdsPath = "assets/colloscope_ids.enc";

  static String stopWordsPath(Locale locale) =>
      "assets/stop_words/sw-${locale.languageCode}.json";

  static const String iconPath = "assets/icon_transparent.png";
  static const String izlyLogoPath = "assets/izly.png";
  static const String izlyMockQrCodePath = "assets/izly_mock_qr-code.png";
  static const String batimentsPath = "assets/batiment_lyon1.json";
  static const String graphPath = 'assets/graph.json.gz';
  static const String discordLogoPath = 'assets/discord_Logo.png';

  static const Duration agendaDayStart = Duration(hours: 6);
  static const Duration agendaDayEnd = Duration(hours: 22);
  static const Duration agendaDayDuration = Duration(
      hours: 16); // be careful to change this value accordingly to the previous
// 22 - 6 = 16

  static final logger = Logger(
    level: (kDebugMode) ? Level.all : Level.fatal,
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static const List<int> peipStudentsAgendaIds = [
    4883,
    4884,
    4885,
    4932,
    4933,
    4934,
    4937,
    4938,
    4940,
    4945,
    4944,
    4946,
    7311,
    7308,
    7317,
    4978,
    4981,
    4985,
    16803,
    16804,
    16805,
    36598,
    36599,
    36600,
    36602,
    36603,
    36604,
    36606,
    45289,
    36607,
    45291,
    36608,
    45293,
    15330,
    6295,
  ];
}

enum Functionalities {
  tomuss,
  agenda,
  mail,
  map,
  izly,
  settings,
  examen,
}
