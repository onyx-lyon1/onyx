import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
import 'package:onyx/screens/map/map_export.dart';

class BatimentsLogic {
  static List<BatimentModel> batiments = [];

  static Future<List<BatimentModel>> findBatiment(String query) async {
    if (batiments.isEmpty) {
      await loadBatiments();
    }
    List<BatimentModel> result = [];
    List<String> queries = query.split(" ");
    for (BatimentModel batiment in batiments) {
      bool isFound = false;
      for (String tmpQuery in queries) {
        if (tmpQuery.isNotEmpty &&
            !removeDiacritics(tmpQuery.toLowerCase()).contains("amphi")) {
          if (removeDiacritics(batiment.name)
                  .toLowerCase()
                  .contains(removeDiacritics(tmpQuery).toLowerCase()) ||
              removeDiacritics(batiment.name.toLowerCase())
                  .contains(removeDiacritics(tmpQuery).toLowerCase())) {
            isFound = true;
            break;
          }
        }
      }
      if (isFound) {
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
