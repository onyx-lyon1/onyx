import 'package:onyx/screens/settings/domain/model/theme_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ThemeExtensions on ThemeModel {
  String translate(AppLocalizations appLocalizations) {
    switch (name) {
      case 'Dark Default':
        return appLocalizations.darkDefault;
      case 'Light Default':
        return appLocalizations.lightDefault;
      case 'Nichi Hachi':
        return appLocalizations.nichiHachi;
      case 'Blue Sky':
        return appLocalizations.blueSky;
      case 'ULTRAKILL':
        return appLocalizations.ultrakill;
      case 'Stardew Valley':
        return appLocalizations.stardewValley;
      case 'Bad Apple':
        return appLocalizations.badApple;
      case 'Moon Light':
        return appLocalizations.moonLight;
      default:
        return name;
    }
  }
}
