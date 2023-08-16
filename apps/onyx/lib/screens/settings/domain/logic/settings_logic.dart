import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
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
    if (Res.mock) {
      return const SettingsModel();
    }
    if (await Hive.boxExists('settings')) {
      Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
      SettingsModel? tmpSettings = box.get('settings');
      if (tmpSettings != null) {
        return tmpSettings;
      } else {
        throw Exception("Settings not found");
      }
    } else {
      return const SettingsModel();
    }
  }

  static Future<void> reset() async {
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    await box.put('settings', const SettingsModel());
  }

  static Future<void> modify({required SettingsModel settings}) async {
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    await box.put('settings', settings);
  }

  static void logout(BuildContext context) {
    CacheService.reset<IzlyCredential>();
    context.read<IzlyCubit>().disconnect();
    Hive.deleteBoxFromDisk("cached_qr_code");
    Hive.deleteBoxFromDisk("cached_izly_amount");
    CacheService.reset<IzlyQrCodeList>();
    CacheService.reset<MailBoxList>();
    CacheService.reset<Agenda>();
    CacheService.reset<TeachingUnitList>();
    CacheService.reset<Lyon1CasClient>();
    CacheService.reset<SettingsModel>();
    context.read<AgendaCubit>().resetCubit();
    context.read<IzlyCubit>().resetCubit();
    context.read<EmailCubit>().resetCubit();
    context.read<MapCubit>().resetCubit();
    context.read<SettingsCubit>().resetCubit();
    context.read<SettingsCubit>().load();
    context.read<TomussCubit>().resetCubit();
    context.read<AuthentificationCubit>().logout();
  }
}
