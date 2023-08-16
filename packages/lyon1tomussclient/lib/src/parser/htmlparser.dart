import 'dart:convert';

import 'package:lyon1tomussclient/src/model/enumeration.dart';
import 'package:lyon1tomussclient/src/model/grade.dart';
import 'package:lyon1tomussclient/src/model/presence.dart';
import 'package:lyon1tomussclient/src/model/semester.dart';
import 'package:lyon1tomussclient/src/model/stage_code.dart';
import 'package:lyon1tomussclient/src/model/teacher.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit.dart';
import 'package:lyon1tomussclient/src/model/tomuss_text.dart';
import 'package:lyon1tomussclient/src/model/upload.dart';
import 'package:lyon1tomussclient/src/model/url.dart';

class HTMLparser {
  late dynamic json;
  late String _rawContent;

  HTMLparser();

  HTMLparser.toJSON(final String rawContent) {
    parse(rawContent);
  }

  void parse(final String rawContent) {
    _rawContent = rawContent;
    final String jsonReady = toJSONready(extractContent(rawContent)) ?? "[]";
    json = jsonDecode(jsonReady);
  }

  String? extractContent(final String rawContent) {
    final RegExp regExp = RegExp("display_update\\((.*?),\"Top\"");
    final RegExpMatch? match = regExp.firstMatch(rawContent);
    return match?.group(1);
  }

  String? toJSONready(String? extractedContent) {
    extractedContent = extractedContent?.replaceAll("\\x3E", ">") ?? "";
    return extractedContent.replaceAll("NaN", "-1");
  }

  int? getIndexForKey(final String name) {
    int i = 0;
    for (var key in json) {
      if (key[0] == name) return i;
      i++;
    }
    return null;
  }

  List<TeachingUnit> extractTeachingUnits() {
    final int? key = getIndexForKey('Grades');
    final String userName =
        json.firstWhere((element) => element[0] == 'Login')[1];
    if (key == null) return [];

    final List<TeachingUnit> units = [];
    for (var unit in json[key][1][0]) {
      List line = unit['line']; // grade value
      Map<String, dynamic> stats =
          unit['stats']; // grade statistics: rank, mediane, average
      List columns = unit['columns']; // grade name

      final List<Teacher> masters = [];
      unit['masters'].forEach((item) => {masters.add(Teacher.fromJSON(item))});

      final List<Grade> grades = [];
      final List<TomussText> texts = [];
      final List<Enumeration> enumerations = [];
      final List<Presence> presences = [];
      final List<StageCode> stageCodes = [];
      final List<Upload> uploads = [];
      final List<URL> urls = [];
      int id = 0;
      for (var item in columns) {
        switch (item['type'].toLowerCase()) {
          case 'note' || 'moy' || 'cow':
            final Grade grade =
                Grade.fromJSON(id, item, stats, line, unit, userName);
            (grade.isValid) ? grades.add(grade) : null;
            break;
          case 'text':
            final TomussText text =
                TomussText.fromJSON(id, item, stats, line, unit, userName);
            (text.isValidText) ? texts.add(text) : null;
            break;
          case 'enumeration' || 'bool':
            enumerations.add(
                Enumeration.fromJSON(id, item, stats, line, unit, userName));
            break;
          case 'prst':
            presences
                .add(Presence.fromJSON(id, item, stats, line, unit, userName));
            break;
          case 'stage_code':
            stageCodes
                .add(StageCode.fromJSON(id, item, stats, line, unit, userName));
            break;
          case 'upload':
            uploads.add(Upload.fromJSON(id, item, stats, line, unit, userName));
            break;
          case 'url':
            urls.add(URL.fromJSON(id, item, stats, line, unit, userName));
            break;
        }
        id++;
      }
      //move children to their parents
      List<Grade> childToRemoveLater = [];
      for (var grade in grades) {
        var column =
            columns.firstWhere((element) => element['title'] == grade.title);
        if (column.keys.contains("columns")) {
          for (var i in column["columns"].split(" ")) {
            if (grades.any((element) => element.title == i)) {
              Grade child = grades.firstWhere((element) => element.title == i);
              grade.addChild(child);
              childToRemoveLater.add(child);
            }
          }
        }
      }
      //remove children from the grades list
      grades.removeWhere((element) => childToRemoveLater.contains(element));

      String ticket =
          RegExp(r'ticket="([^\s";]+)').firstMatch(_rawContent)?.group(1) ?? "";
      units.add(TeachingUnit(
          unit['table_title'] ?? unit['ue'],
          masters,
          grades,
          texts,
          enumerations,
          presences,
          stageCodes,
          uploads,
          urls,
          ticket,
          unit['ue']));
    }
    return units;
  }

  List<Semester> extractSemesters() {
    final int? key = getIndexForKey('Semesters');
    if (key == null) return [];

    final List<Semester> semesters = [];
    for (var item in json[key][1].keys) {
      semesters.add(Semester(item, json[key][1][item]));
    }
    return semesters;
  }

  List<Grade> extractWeekGrades() {
    return [];
  }
}
