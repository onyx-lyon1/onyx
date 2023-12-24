import 'package:diacritic/diacritic.dart';

class SearchService {
  static bool isMatch(String a, String b) {
    final stopWords = [
      "le",
      "la",
      "un",
      "une",
      "des",
      "d'un",
      "d'une",
      "en",
      "a",
      "de",
      "cafeteria",
      "restaurant"
    ];

    List<String> aTerms = a.toLowerCase().split(" ");
    aTerms = aTerms.where((term) => term.length > 1).toList();
    aTerms = aTerms.map((e) => removeDiacritics(e)).toList();
    
    //remove special characters
    aTerms = aTerms.map((e) => e.replaceAll(RegExp(r"[^\w\s]"), '')).toList();
    aTerms = aTerms.where((term) => !term.contains("amphi")).toList();

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
