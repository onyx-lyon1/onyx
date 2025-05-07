import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/screens/settings/widgets/theme_swap/theme_list_expansion_tile.dart';
import 'package:onyx/l10n/app_localizations.dart';

class ThemesSwap extends StatefulWidget {
  const ThemesSwap({super.key});

  @override
  State<ThemesSwap> createState() => _ThemesSwapState();
}

class _ThemesSwapState extends State<ThemesSwap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).changeTheme),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ThemeListExpansionTile(
                  title: AppLocalizations.of(context).favoriteTheme,
                  themesPreset: themeState.themesSettings!.favoriteThemes,
                  themesCreated: const [],
                ),
                ThemeListExpansionTile(
                  title: AppLocalizations.of(context).lightTheme,
                  themesPreset: OnyxTheme.themesPresetLight,
                  themesCreated: themeState.themesSettings!.lightThemesCreated,
                ),
                ThemeListExpansionTile(
                  title: AppLocalizations.of(context).darkTheme,
                  themesPreset: OnyxTheme.themesPresetDark,
                  themesCreated: themeState.themesSettings!.darkThemesCreated,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
