import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onyx/core/extensions/theme_extensions.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.themesCreated,
    required this.themesPreset,
  });

  final List<ThemeModel> themesPreset;
  final List<ThemeModel> themesCreated;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        List<ThemeModel> listThemes = themesCreated + themesPreset;
        return GridView.builder(
          shrinkWrap: true,
          padding: listThemes.isNotEmpty ? const EdgeInsets.all(10.0) : null,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: listThemes.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              context
                  .read<ThemeCubit>()
                  .chooseTheme(listThemes[index])
                  .then((value) {
                if (state.themesSettings!.autoSwitchTheme) {
                  context.read<ThemeCubit>().updateThemeMode(
                      listThemes[index].theme.brightness.toThemeModeEnum);
                }
              });
            },
            onDoubleTap: () {
              context.read<ThemeCubit>().toggleThemeFavorite(listThemes[index]);
            },
            // onLongPress: () {
            //   if (state.themesSettings!.themesPreset
            //       .contains(listThemes[index])) {
            //     popupMenuThemeCreated(context, listThemes[index]);
            //   }
            // },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: listThemes[index].theme.cardColor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: listThemes[index].theme.colorScheme.primary,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      listThemes[index].translate(AppLocalizations.of(context)),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: ((listThemes[index].name ==
                                    state.themesSettings!.darkThemeSelected ||
                                listThemes[index].name ==
                                    state.themesSettings!.lightThemeSelected))
                            ? FontWeight.w900
                            : FontWeight.normal,
                        color: listThemes[index]
                                .theme
                                .textTheme
                                .labelLarge
                                ?.color ??
                            Colors.black,
                      ),
                    ),
                  ),
                ),
                if (state.themesSettings!.favoriteThemes.indexWhere(
                        (element) => element.name == listThemes[index].name) !=
                    -1)
                  Positioned(
                    top: 15,
                    right: 18 - (index + 1) % 2 * 2,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void popupMenuThemeCreated(BuildContext context, ThemeModel theme) {
    final RenderBox renderBox = context.findRenderObject()! as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40),
        Offset.zero & context.size!,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          value: 0,
          child: Text(AppLocalizations.of(context).modify),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(AppLocalizations.of(context).delete),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 0:
            break;
          case 1:
            context.read<ThemeCubit>().deleteTheme(theme);
            break;
        }
      }
    });
  }
}
