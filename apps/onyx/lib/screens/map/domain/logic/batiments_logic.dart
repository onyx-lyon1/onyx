import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:onyx/screens/map/map_export.dart';

class BatimentsLogic {
  static Future<List<BatimentModel>> loadBatiments() async {
    String jsonString =
        await rootBundle.loadString("assets/batiment_lyon1.json");
    List<dynamic> rawBatiments = jsonDecode(jsonString);
    return rawBatiments.map((e) => BatimentModel.fromJson(e)).toList();
  }
}
