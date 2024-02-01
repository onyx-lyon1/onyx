import 'dart:ui';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:onyx/core/res.dart';

class SearchService {
  static Future<bool> isMatch(String a, String b, Locale locale) async {
    final stopWords =
        (json.decode(await rootBundle.loadString(Res.stopWordsPath(locale)))
                as List<dynamic>)
            .cast<String>();

    List<String> aTerms = a.toLowerCase().split(" ");
    aTerms = aTerms.where((term) => term.length > 1).toList();
    aTerms = aTerms.map((e) => removeDiacritics(e)).toList();

    //remove stop words
    aTerms = aTerms.where((term) => !stopWords.contains(term)).toList();

    b = b.toLowerCase();
    b = removeDiacritics(b);
    //remove special characters
    b = b.replaceAll(RegExp(r"[^\w\s]"), '');

    for (var term in aTerms) {
      if (b.contains(term)) {
        return true;
      }
    }
    return false;
  }
}
