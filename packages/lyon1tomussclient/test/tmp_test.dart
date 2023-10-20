import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("test write read", () {
    TeachingUnitElement element = TeachingUnitElement(
        title: "title", author: "author", date: DateTime.now(), position: 0);
    print(element.toJson());
  });

  test("test write", () {
    TeachingUnitElement element = TeachingUnitElementMapper.fromJson(
        '{"author":"author","date":"2023-10-20T08:18:46.385047Z","position":0.0}');
    print(elementtitle);
  });
}
