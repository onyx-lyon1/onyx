import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:onyx/core/cache_service.dart';

void main() {
  setUpAll(() {
    //clean dirs if exist
    if (Directory("/tmp/onyx").existsSync()) {
      Directory("/tmp/onyx").deleteSync(recursive: true);
    }
    CacheService.init(
        cachePath: "/tmp/onyx/cache", permanentPath: "/tmp/onyx/permanent");
    CacheService.registerAdapter<TestObject>(TestObject.fromMap);
  });
  setUp(() {
    CacheService.resetAll();
  });

  test("reset all", () {
    //create many files in temp
    for (int i = 0; i < 10; i++) {
      File("/tmp/onyx/cache/TestObject_$i.data")
          .writeAsStringSync('{"name":"test$i","age":$i}');
    }
    for (int i = 0; i < 10; i++) {
      File("/tmp/onyx/permanent/TestObject_$i.data")
          .writeAsStringSync('{"name":"test$i","age":$i}');
    }
    //check if files exist
    for (int i = 0; i < 10; i++) {
      expect(
          File("/tmp/onyx/cache/TestObject_$i.data").existsSync(), true);
      expect(File("/tmp/onyx/permanent/TestObject_$i.data").existsSync(),
          true);
    }
    //reset all
    CacheService.resetAll();
    //check if files are deleted
    for (int i = 0; i < 10; i++) {
      expect(File("/tmp/onyx/cache/TestObject_$i.data").existsSync(),
          false);
      expect(File("/tmp/onyx/permanent/TestObject_$i.data").existsSync(),
          false);
    }
  });

  test("write test perma", () {
    TestObject testObject = TestObject("test", 1);
    CacheService.set(testObject, permanent: true);
    expect(File("/tmp/onyx/permanent/TestObject_0.data").existsSync(),
        true);
    expect(
        File("/tmp/onyx/permanent/TestObject_0.data").readAsStringSync(),
        '{"name":"test","age":1}');
  });
  test("write test temporary", () {
    TestObject testObject = TestObject("test", 1);
    CacheService.set(testObject, permanent: false);
    expect(File("/tmp/onyx/cache/TestObject_0.data").existsSync(), true);
    expect(File("/tmp/onyx/cache/TestObject_0.data").readAsStringSync(),
        '{"name":"test","age":1}');
  });

  test("write test with index", () {
    TestObject testObject = TestObject("test", 1);
    CacheService.set(testObject, permanent: true, index: 999);
    expect(File("/tmp/onyx/permanent/TestObject_999.data").existsSync(),
        true);
    expect(
        File("/tmp/onyx/permanent/TestObject_999.data")
            .readAsStringSync(),
        '{"name":"test","age":1}');
  });

  test('write list test', () {
    List<TestObject> list =
        List.generate(10, (index) => TestObject("test$index", index));
    CacheService.set(list, permanent: true);
    expect(
        File("/tmp/onyx/permanent/List<TestObject>_0.data").existsSync(),
        true);
    expect(
        File("/tmp/onyx/permanent/List<TestObject>_0.data")
            .readAsStringSync(),
        '[{"name":"test0","age":0},{"name":"test1","age":1},{"name":"test2","age":2},{"name":"test3","age":3},{"name":"test4","age":4},{"name":"test5","age":5},{"name":"test6","age":6},{"name":"test7","age":7},{"name":"test8","age":8},{"name":"test9","age":9}]');
  });

  test('read test perma', () {
    File("/tmp/onyx/permanent/TestObject_0.data")
        .writeAsStringSync('{"name":"test","age":1}');
    TestObject? testObject = CacheService.get<TestObject>(permanent: true);
    expect(testObject!.name, "test");
    expect(testObject.age, 1);
  });

  test('read test temporary', () {
    File("/tmp/onyx/cache/TestObject_0.data")
        .writeAsStringSync('{"name":"test","age":1}');
    TestObject? testObject = CacheService.get<TestObject>(permanent: false);
    expect(testObject!.name, "test");
    expect(testObject.age, 1);
  });

  test('read list test', () {
    File("/tmp/onyx/cache/List<TestObject>_0.data").writeAsStringSync(
        '[{"name":"test0","age":0},{"name":"test1","age":1},{"name":"test2","age":2},{"name":"test3","age":3},{"name":"test4","age":4},{"name":"test5","age":5},{"name":"test6","age":6},{"name":"test7","age":7},{"name":"test8","age":8},{"name":"test9","age":9}]');
    List<TestObject> list = CacheService.get<List<TestObject>>()!;
    expect(list.length, 10);
    for (int i = 0; i < 10; i++) {
      expect(list[i].name, "test$i");
      expect(list[i].age, i);
    }
  });

  test("write basic type list", () {
    List<int> list = List.generate(10, (index) => index);
    CacheService.set(list, permanent: true);
    expect(
        File("/tmp/onyx/permanent/List<int>_0.data").existsSync(), true);
    expect(
        File("/tmp/onyx/permanent/List<int>_0.data").readAsStringSync(),
        '[0,1,2,3,4,5,6,7,8,9]');
  });

  test("read basic type list", () {
    File("/tmp/onyx/cache/List<int>_0.data").writeAsStringSync('[0,1,2,3,4,5,6,7,8,9]');
    List<int> list = CacheService.get<List<int>>()!;
    expect(list.length, 10);
    for (int i = 0; i < 10; i++) {
      expect(list[i], i);
    }
  });

  test("exist", (){
    expect(CacheService.exist<TestObject>(), false);
    CacheService.set<TestObject>(TestObject("test", 1));
    expect(CacheService.exist<TestObject>(), true);
  });
}

class TestObject {
  late String name;
  late int age;

  TestObject(this.name, this.age);

  TestObject.fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    name = data['name'];
    age = data['age'];
  }

  TestObject.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    age = map['age'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['age'] = age;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['age'] = age;
    return data;
  }
}
