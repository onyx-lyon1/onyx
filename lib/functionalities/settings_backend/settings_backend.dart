import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/model/settings.dart';

class SettingsBackend{
  static Future<SettingsModel> load() async{
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    SettingsModel? tmpSettings = box.get('settings');
    if (tmpSettings != null) {
      return tmpSettings;
    }else{
      throw Exception("Settings not found");
    }
  }
  static Future<void> reset() async{
    Box<SettingsModel> box = Hive.box<SettingsModel>('settings');
    await box.put('settings', SettingsModel());
  }
  static Future<void> modify({required SettingsModel settings}) async{
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    await box.put('settings', settings);
  }
}