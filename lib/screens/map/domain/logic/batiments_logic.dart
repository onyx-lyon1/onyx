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
    return batiments
        .where((element) =>
            removeDiacritics(element.name)
                .toLowerCase()
                .contains(removeDiacritics(query).toLowerCase()) ||
            removeDiacritics(query)
                .toLowerCase()
                .contains(removeDiacritics(element.name).toLowerCase()))
        .map((element) {
      return BatimentModel(
        element.name,
        element.position,
      );
    }).toList();
  }

  static Future<void> loadBatiments() async {
    String jsonString =
        await rootBundle.loadString("assets/batiment_lyon1.json");
    List<dynamic> rawBatiments = jsonDecode(jsonString);
    batiments = rawBatiments.map((e) => BatimentModel.fromJson(e)).toList();
  }
}
