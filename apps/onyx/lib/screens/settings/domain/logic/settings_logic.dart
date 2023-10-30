// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class SettingsLogic {
  static Future<SettingsModel> load() async {
    SettingsModel? tmpSettings =
        CacheService.get<SettingsModel>(permanent: true);
    if (tmpSettings != null) {
      Res.mock = tmpSettings.mock;
      return tmpSettings;
    } else {
      throw Exception("Settings not found");
    }
  }

  static void reset() {
    CacheService.reset<SettingsModel>(permanent: true);
  }

  static void modify({required SettingsModel settings}) {
    CacheService.set<SettingsModel>(settings, permanent: true);
  }

  static void logout(BuildContext context) async {
    Res.mock = false;
    await context.read<AuthentificationCubit>().logout();
    CacheService.resetAll();
    context.read<IzlyCubit>().disconnect();
    File("${CacheService.cachePath}/cached_izly_amount.data").deleteSync();
    context.read<AgendaCubit>().resetCubit();
    context.read<IzlyCubit>().resetCubit();
    context.read<EmailCubit>().resetCubit();
    context.read<MapCubit>().resetCubit();
    reset();
    context.read<SettingsCubit>().resetCubit();
    context.read<SettingsCubit>().load();
    context.read<TomussCubit>().resetCubit();
  }
}
