import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class BatimentsLogic {
  static Future<List<BatimentModel>> loadBatiments(
      SettingsState settings) async {
    String jsonString = await rootBundle.loadString(Res.batimentsPath);
    List<dynamic> rawBatiments = jsonDecode(jsonString);
    return rawBatiments
        .map((e) => BatimentModel.fromJson(e, settings))
        .toList();
  }
}
