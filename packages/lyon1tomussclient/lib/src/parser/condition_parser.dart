import 'dart:math';

extension ConditionParser on String {
  bool evaluateCondition(
      {required String value, required var line, required var column}) {
    try {
      value = value.toLowerCase();
      if (this == "null") {
        return false;
      }
      String condition = toLowerCase()
          .replaceAllMapped(RegExp(r'\\x([0-9a-fA-F]{2})'), (match) {
        return String.fromCharCode(int.parse(match.group(1)!, radix: 16));
      });
      String cleanCondition = "";
      for (var i = 0; i < condition.length; i++) {
        if (condition[i] == '[') {
          if (condition[i+1] == "]") {
            return false;
          }
          
          int j = condition.indexOf(']', i);
          if (j > 0) {
            String query = condition.substring(i + 1, j);
            int element = column["columns"]
                .firstWhere(
                    (element) => element['title'].toLowerCase() == query,
                    orElse: () => {"position": "0"})["position"]
                .toInt();
            cleanCondition += line[element][0].toString();
            i = j;
          }
        } else {
          cleanCondition += condition[i];
        }
      }
      condition = cleanCondition;

      List tmpResults = [];
      int sup = condition.indexOf(">");
      int inf = condition.indexOf("<");
      int eq = condition.indexOf("=");
      int neq = condition.indexOf("!");
      if (sup == -1 && inf == -1 && eq == -1 && neq == -1) {
        tmpResults.add(value.compareTo(condition) == 0);
      } else {
        for (var cond in condition.split(" ")) {
          int sup = cond.indexOf(">");
          int inf = cond.indexOf("<");
          int eq = cond.indexOf("=");
          int neq = cond.indexOf("!");
          String compValue;
          if ((sup == 0 || inf == 0 || eq == 0 || neq == 0) ||
              (sup == -1 && inf == -1 && eq == -1 && neq == -1)) {
            compValue = value;
          } else {
            List<int> indexes = [sup, inf, eq, neq];
            indexes.removeWhere((element) => element == -1);
            compValue = cond.substring(
                0, indexes.reduce((value, element) => min(value, element)));
          }
          if (sup != -1) {
            if (eq != -1) {
              tmpResults.add(compValue.compareTo(cond.substring(sup + 2)) >= 0);
            } else {
              tmpResults.add(compValue.compareTo(cond.substring(sup + 1)) > 0);
            }
          } else if (inf != -1) {
            if (eq != -1) {
              tmpResults.add(compValue.compareTo(cond.substring(inf + 2)) <= 0);
            } else {
              tmpResults.add(compValue.compareTo(cond.substring(inf + 1)) < 0);
            }
          } else if (eq != -1) {
            if (neq != -1) {
              tmpResults.add(compValue.compareTo(cond.substring(neq + 2)) != 0);
            } else {
              tmpResults.add(compValue.compareTo(cond.substring(eq + 1)) == 0);
            }
          } else if (eq != -1) {
            if (neq != -1) {
              tmpResults.add(compValue.compareTo(cond.substring(neq + 2)) != 0);
            } else {
              tmpResults.add(compValue.compareTo(cond.substring(eq + 1)) == 0);
            }
          } else if (cond == "ou" || cond == "et") {
            tmpResults.add(cond);
          } else if (sup == -1 && inf == -1 && eq == -1 && neq == -1) {
            tmpResults.add(compValue.compareTo(cond) == 0);
          }
        }
      }
      List<bool> appliedConnectors = [];
      for (int i = 0; i < tmpResults.length; i++) {
        if (tmpResults[i] is String) {
          if (tmpResults[i] == "ou") {
            appliedConnectors.add(tmpResults[i - 1] || tmpResults[i + 1]);
          } else if (tmpResults[i] == "et") {
            appliedConnectors.add(tmpResults[i - 1] && tmpResults[i + 1]);
          }
        }
      }
      bool finalResult = false;
      if (appliedConnectors.isEmpty) {
        finalResult = tmpResults[0];
      } else {
        finalResult = appliedConnectors[0];
        for (int i = 1; i < appliedConnectors.length; i++) {
          finalResult = finalResult && appliedConnectors[i];
        }
      }
      return finalResult;
    } catch (e) {
      print("Error : $e while parsing the condition: $this");
      return true;
    }
  }
}
