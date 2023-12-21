import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:onyx/core/res.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

part 'colloscope_state.dart';

class ColloscopeCubit extends Cubit<ColloscopeState> {
  PolytechColloscopeClient? _colloscopeClient;

  ColloscopeCubit()
      : super(const ColloscopeState(
            status: ColloscopeStatus.initial, studentColloscope: null));

  void load(String name, String surname, String username, int yearOverride,
      int studentOverride) async {
    if (Res.mock) {
      emit(state.copyWith(
        status: ColloscopeStatus.ready,
        studentColloscope:
            StudentColloscope(Student(Year.second, "Oui", 351), 10, [
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              "Oui Room"),
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              "Oui Room"),
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              "Oui Room"),
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              null),
        ]),
      ));

      return;
    }

    Box box = await Hive.openBox<StudentColloscope>("cached_colloscope_data");
    StudentColloscope cachedColloscope =
        box.get("colloscope") ?? StudentColloscope.empty();
    box.close();

    emit(state.copyWith(
      status: ColloscopeStatus.gatheringColloscopeData,
      studentColloscope: cachedColloscope,
    ));

    try {
      final encrypted = await rootBundle.loadString(Res.colloscopeIdsPath);
      final key = Key.fromBase64(await rootBundle.loadString(Res.keyPath));
      final iv = IV.fromBase64(await rootBundle.loadString(Res.ivPath));
      final encrypter = Encrypter(AES(key));
      final decrypted =
          encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);
      final decoded = base64.decode(decrypted);
      final deziped = gzip.decode(decoded);
      final jsonText = utf8.decode(deziped);

      final json = jsonDecode(jsonText);

      _colloscopeClient =
          PolytechColloscopeClient(json["username"], json["password"]);

      int? year;

      if (yearOverride != 0) {
        year = yearOverride;
      } else if (RegExp(r"^([pP])\d{7}$").hasMatch(username.trim())) {
        year = int.parse(username.substring(1, 3));
        year = DateTime.now().year - 2000 - year + 1;
      }

      Student? student;

      if (studentOverride != -1) {
        student = Student(Year.values[year! - 1], name, studentOverride);
      } else {
        student = await _colloscopeClient!
            .fetchStudent(Year.values[year! - 1], name, surname);
      }

      StudentColloscope colloscope =
          await _colloscopeClient!.getColloscope(student!);

      box = await Hive.openBox<StudentColloscope>("cached_colloscope_data");
      await box.put("colloscope", colloscope);
      box.close();

      emit(state.copyWith(
        status: ColloscopeStatus.ready,
        studentColloscope: colloscope,
      ));
    } catch (e) {
      emit(state.copyWith(status: ColloscopeStatus.error));
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        Connectivity().onConnectivityChanged.listen((event) async {
          if (event != ConnectivityResult.none) {
            resetCubit();
          }
        });
      }
    }
  }

  void resetCubit() {
    emit(state.copyWith(status: ColloscopeStatus.initial));
  }
}
