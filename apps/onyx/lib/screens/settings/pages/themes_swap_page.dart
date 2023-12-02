import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/screens/settings/widgets/theme_swap/theme_list_expansion_tile.dart';

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
        title: const Text("Changer les thèmes"),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ThemeListExpansionTile(
                  title: "Thèmes favoris",
                  themesPreset: themeState.themesSettings!.favoriteThemes,
                  themesCreated: const [],
                ),
                ThemeListExpansionTile(
                  title: "Thèmes clairs",
                  themesPreset: OnyxTheme.themesPresetLight,
                  themesCreated: themeState.themesSettings!.lightThemesCreated,
                ),
                ThemeListExpansionTile(
                  title: "Thèmes sombres",
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
