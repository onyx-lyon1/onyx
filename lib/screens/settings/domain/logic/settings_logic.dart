import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/settings/domain/model/settings_model.dart';

class SettingsLogic {
  static Future<SettingsModel> load() async {
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
    Box<SettingsModel> box = Hive.box<SettingsModel>('settings');
    await box.put('settings', SettingsModel());
  }

  static Future<void> modify({required SettingsModel settings}) async {
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    await box.put('settings', settings);
  }
}
