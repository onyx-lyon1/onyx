// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class SettingsLogic {
  static Future<Database> _getDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'settings.db');
    return await databaseFactoryIo.openDatabase(dbPath);
  }

  static final _settingsStore = StoreRef<String, Map<String, dynamic>>(
    'settings_store',
  );

  static Future<SettingsModel> load() async {
    final db = await _getDb();
    final map = await _settingsStore.record('settings').get(db);
    if (map != null) {
      final tmpSettings = SettingsModelMapper.fromMap(map);
      Res.mock = tmpSettings.mock;
      return tmpSettings;
    } else {
      return const SettingsModel();
    }
  }

  static Future<void> reset() async {
    final db = await _getDb();
    await _settingsStore
        .record('settings')
        .put(db, const SettingsModel().toMap());
  }

  static Future<void> modify({required SettingsModel settings}) async {
    final db = await _getDb();
    await _settingsStore.record('settings').put(db, settings.toMap());
  }

  static void logout(BuildContext context) async {
    Res.mock = false;
    await context.read<AuthentificationCubit>().logout();
    CacheService.reset<IzlyCredential>();
    context.read<IzlyCubit>().disconnect();
    // Suppression des fichiers Sembast de cache
    final dir = await getApplicationDocumentsDirectory();
    await databaseFactoryIo.deleteDatabase(join(dir.path, 'cached_qr_code.db'));
    await databaseFactoryIo.deleteDatabase(
      join(dir.path, 'cached_izly_amount.db'),
    );
    await databaseFactoryIo.deleteDatabase(
      join(dir.path, 'cached_colloscope_data.db'),
    );
    CacheService.reset<IzlyQrCodeList>();
    CacheService.reset<IzlyPaymentModelList>();
    CacheService.reset<Lyon1CasClient>();
    CacheService.reset<SettingsModel>();
    context.read<AgendaCubit>().resetCubit();
    context.read<IzlyCubit>().resetCubit();
    context.read<EmailCubit>().resetCubit();
    context.read<MapCubit>().resetCubit();
    await reset();
    context.read<SettingsCubit>().resetCubit();
    context.read<SettingsCubit>().load();
    context.read<TomussCubit>().resetCubit();
  }
}
