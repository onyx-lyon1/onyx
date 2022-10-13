import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if (kDebugMode) {
      print(
        "Native called background task: $task");
    } //simpleTask will be emitted here.
    return Future.value(true);
  });
}
