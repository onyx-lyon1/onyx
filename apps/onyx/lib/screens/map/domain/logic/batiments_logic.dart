import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:onyx/core/search/search_service.dart';
import 'package:onyx/screens/map/map_export.dart';

class BatimentsLogic {
  static List<BatimentModel> batiments = [];

  static Future<List<BatimentModel>> findBatiment(String query) async {
    if (batiments.isEmpty) {
      await loadBatiments();
    }
    List<BatimentModel> result = [];
    for (BatimentModel batiment in batiments) {
      if (SearchService.isMatch(query, batiment.name)) {
        result.add(batiment);
      }
    }
    return result;
  }

  static Future<void> loadBatiments() async {
    String jsonString =
        await rootBundle.loadString("assets/batiment_lyon1.json");
    List<dynamic> rawBatiments = jsonDecode(jsonString);
    batiments = rawBatiments.map((e) => BatimentModel.fromJson(e)).toList();
  }
}
