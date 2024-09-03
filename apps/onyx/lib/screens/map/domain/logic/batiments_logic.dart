import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/map/map_export.dart';

class BatimentsLogic {
  static Future<List<BatimentModel>> loadBatiments(Locale locale) async {
    String jsonString = await rootBundle.loadString(Res.batimentsPath);
    List<dynamic> rawBatiments = jsonDecode(jsonString);
    return rawBatiments.map((e) => BatimentModel.fromJson(e, locale)).toList();
  }
}
