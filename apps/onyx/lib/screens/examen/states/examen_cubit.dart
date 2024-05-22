import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'examen_state.dart';

class ExamenCubit extends Cubit<ExamenState> {
  PolytechColloscopeClient? _colloscopeClient;
  Lyon1ExamenClient? _lyon1ExamenClient;

  ExamenCubit()
      : super(
          const ExamenState(
            status: ExamenStatus.initial,
            studentColloscope: null,
            reloadScheduled: false,
            examens: [],
          ),
        );

  void load(
    String name,
    String surname,
    String username,
    SettingsModel settings,
    Lyon1CasClient authentication,
    AppLocalizations appLocalization,
  ) async {
    if (Res.mock) {
      emit(
        state.copyWith(
          status: ExamenStatus.ready,
          studentColloscope: (settings.colloscopeEnabled ?? false)
              ? StudentColloscope(
                  Student(Year.second, appLocalization.mockStudent, 351), 10, [
                  Kholle(
                      DateTime.now(),
                      appLocalization.mockSchoolSubject,
                      appLocalization.mockTutorialLeader,
                      appLocalization.mockMessage,
                      appLocalization.mockRoom),
                  Kholle(
                      DateTime.now(),
                      appLocalization.mockSchoolSubject,
                      appLocalization.mockTutorialLeader,
                      appLocalization.mockMessage,
                      appLocalization.mockRoom),
                  Kholle(
                      DateTime.now(),
                      appLocalization.mockSchoolSubject,
                      appLocalization.mockTutorialLeader,
                      appLocalization.mockMessage,
                      appLocalization.mockRoom),
                  Kholle(
                      DateTime.now(),
                      appLocalization.mockSchoolSubject,
                      appLocalization.mockTutorialLeader,
                      appLocalization.mockMessage,
                      null),
                ])
              : null,
          examens: [
            ExamenModel(
              appLocalization.mockTitle,
              appLocalization.mockCodeName,
              DateTime.now(),
              const Duration(hours: 2),
              appLocalization.mockRoom,
              42,
            ),
          ],
        ),
      );

      return;
    }

    if (settings.colloscopeEnabled ?? false) {
      StudentColloscope cachedColloscope =
          await CacheService.get<StudentColloscope>() ??
              StudentColloscope.empty();
      emit(state.copyWith(
        status: ExamenStatus.loading,
        studentColloscope: cachedColloscope,
      ));
    } else {
      emit(state.resetColloscope());
    }

    ExamenListModel cachedExamens =
        await CacheService.get<ExamenListModel>() ?? ExamenListModel([]);

    emit(state.copyWith(
      status: ExamenStatus.loading,
      examens: cachedExamens.examens,
    ));

    try {
      //Colloscope
      if ((settings.colloscopeEnabled ?? false) &&
          name.isNotEmpty &&
          surname.isNotEmpty) {
        int yearOverride = settings.colloscopeOverrideYearId;
        int studentOverride = settings.colloscopeOverrideStudentId;

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
          year = DateTime.now().year -
              2000 -
              year +
              (DateTime.now().month >= 6 ? 1 : 0);
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

        CacheService.set<StudentColloscope>(colloscope);

        emit(state.copyWith(
          status: ExamenStatus.ready,
          studentColloscope: colloscope,
        ));
      }
      //Examen

      _lyon1ExamenClient = Lyon1ExamenClient(authentication);
      List<ExamenModel> examList = await _lyon1ExamenClient!.fetchExams();
      CacheService.set<ExamenListModel>(ExamenListModel(examList));

      emit(state.copyWith(
        status: ExamenStatus.ready,
        examens: examList,
      ));
    } catch (e) {
      Res.logger.e(e);
      emit(state.copyWith(status: ExamenStatus.error));
      if ((await Connectivity().checkConnectivity())
          .contains(ConnectivityResult.none)) {
        Connectivity().onConnectivityChanged.listen((event) async {
          if (!event.contains(ConnectivityResult.none)) {
            resetCubit();
          }
        });
      }
    }
  }

  void resetCubit() {
    emit(state.copyWith(
        status: ExamenStatus.initial,
        studentColloscope: null,
        reloadScheduled: false));
  }

  void scheduleReload() {
    emit(state.copyWith(reloadScheduled: true));
  }
}
