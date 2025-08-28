import 'package:hive_ce/hive.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:onyx/screens/settings/domain/model/theme_mode_enum.dart';
import 'package:onyx/screens/settings/domain/model/theme_model.dart';
import 'package:onyx/screens/settings/domain/model/theme_settings_model.dart';

@GenerateAdapters([
  AdapterSpec<SettingsModel>(),
  AdapterSpec<ThemeModeEnum>(),
  AdapterSpec<Functionalities>(),
  AdapterSpec<ThemeSettingsModel>(),
])
part 'generated/hive_adapters.g.dart';
