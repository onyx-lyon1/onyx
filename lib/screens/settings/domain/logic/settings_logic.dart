import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class SettingsLogic {
  static Future<SettingsModel> load() async {
    if (Res.mock) {
      return SettingsModel();
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
      return SettingsModel();
    }
  }

  static Future<void> reset() async {
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    await box.put('settings', SettingsModel());
  }

  static Future<void> modify({required SettingsModel settings}) async {
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    await box.put('settings', settings);
  }
}
