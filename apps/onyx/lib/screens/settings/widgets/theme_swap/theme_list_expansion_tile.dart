import 'package:flutter/material.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/widgets/theme_swap/theme_button.dart';

class ThemeListExpansionTile extends StatelessWidget {
  const ThemeListExpansionTile({
    super.key,
    required this.title,
    required this.themesPreset,
    required this.themesCreated,
  });
  final String title;
  final List<ThemeModel> themesPreset;
  final List<ThemeModel> themesCreated;
  @override
  Widget build(BuildContext context) {
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
          children: [
            ThemeButton(
              themesCreated: themesCreated,
              themesPreset: themesPreset,
            ),
          ],
        ),
      ),
    );
  }
}
