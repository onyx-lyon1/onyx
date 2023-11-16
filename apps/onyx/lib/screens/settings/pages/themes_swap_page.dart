import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/core/theme/theme_export.dart';

class ThemesSwap extends StatefulWidget {
  const ThemesSwap({
    super.key,
  });

  @override
  State<ThemesSwap> createState() => _ThemesSwapState();
}

class _ThemesSwapState extends State<ThemesSwap> {
  late ThemesUserData themesUserData;
  late List<ThemeInfo> themeCreatedLight;
  late List<ThemeInfo> themeCreatedDark;

  @override
  void initState() {
    super.initState();
    _loadThemesUserData();
  }

  Future<void> _loadThemesUserData() async {
    themesUserData = BlocProvider.of<ThemeCubit>(context).themesUserData;
    themeCreatedLight = BlocProvider.of<ThemeCubit>(context)
        .themesCreated
        .where((themeInfo) => themeInfo.theme.brightness == Brightness.light)
        .toList();
    themeCreatedDark = BlocProvider.of<ThemeCubit>(context)
        .themesCreated
        .where((themeInfo) => themeInfo.theme.brightness == Brightness.dark)
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Changer les thèmes"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          expansionTheme(context, "Thèmes favoris",
              listJsonToThemeInfo(themesUserData.favoriteThemes)),
          expansionTheme(context, "Thèmes clairs", themesPresetLight,
              themesCreated: themeCreatedLight),
          expansionTheme(context, "Thèmes sombres", themesPresetDark,
              themesCreated: themeCreatedDark),
        ])));
  }

  Widget expansionTheme(
      BuildContext context, String title, List<ThemeInfo> themesPreset,
      {List<ThemeInfo> themesCreated = const []}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
            ),
          ),
          children: <Widget>[
            themesPrint(context, themesPreset, themesCreated),
          ],
        ),
      ),
    );
  }

  ListView themesPrint(BuildContext context, List<ThemeInfo> listThemesPreset,
      List<ThemeInfo> listThemesCreated) {
    return ListView(shrinkWrap: true, children: [
      GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
          ),
          itemCount: listThemesPreset.length + listThemesCreated.length,
          itemBuilder: (context, index) {
            ThemeInfo theme;
            if (index < listThemesPreset.length) {
              theme = listThemesPreset[index];
            } else {
              theme = listThemesCreated[index - listThemesPreset.length];
            }

            EdgeInsets itemPadding = const EdgeInsets.all(5.0);
            if (index % 2 == 0) {
              itemPadding = const EdgeInsets.fromLTRB(8.0, 5.0, 5.0, 5.0);
            } else {
              itemPadding = const EdgeInsets.fromLTRB(5.0, 5.0, 8.0, 5.0);
            }

            return Builder(builder: (BuildContext builderContext) {
              return GestureDetector(
                  onTap: () {
                    context.read<ThemeCubit>().loadTheme(theme);
                    context.read<ThemeCubit>().saveChangeTheme(theme);
                    if (themesUserData.changeAutoTheme) {
                      context.read<SettingsCubit>().modify(
                          settings: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .copyWith(
                                  themeMode: (theme.theme.brightness ==
                                          Brightness.light)
                                      ? ThemeModeEnum.light
                                      : ThemeModeEnum.dark));
                    }
                  },
                  onDoubleTap: () {
                    context.read<ThemeCubit>().setThemeFavorite(context, theme);
                  },
                  onLongPress: () {
                    if (index >= listThemesPreset.length) {
                      popupMenuThemeCreated(builderContext, theme);
                    }
                  },
                  child: Padding(
                      padding: itemPadding,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.theme.cardColor,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: theme.theme.colorScheme.primary,
                            width: 4,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            theme.name.replaceAll('_', ' '),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: ((theme.name ==
                                          themesUserData.darkThemeSelected ||
                                      theme.name ==
                                          themesUserData.lightThemeSelected))
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: theme.theme.textTheme.labelLarge?.color ??
                                  Colors.black,
                            ),
                          ),
                        ),
                      )));
            });
          }),
    ]);
  }

  void popupMenuThemeCreated(BuildContext context, ThemeInfo theme) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40),
        Offset.zero & context.size!,
      ),
      items: <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'Modifier',
          child: Text('Modifier'),
        ),
        const PopupMenuItem(
          value: 'Supprimer',
          child: Text('Supprimer'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 'Modifier':
            break;
          case 'Supprimer':
            context.read<ThemeCubit>().deleteTheme(theme.name);
            //Reload the page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const ThemesSwap();
                },
              ),
            );
            break;
        }
      }
    });
  }
}
