import 'package:flutter/material.dart';
import 'package:oloid2/core/widgets/core_widget_export.dart';

class BottomNavBarComponentWidget extends StatelessWidget {
  const BottomNavBarComponentWidget(
      {Key? key, required this.index, required this.currentIndex})
      : super(key: key);
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return TomussBottomNavBarIcon(selected: (index == currentIndex));
      case 1:
        return AgendaBottomNavBarIcon(selected: (index == currentIndex));
      case 2:
        return EmailBottomNavBarIcon(selected: (index == currentIndex));
      case 3:
        return SettingsBottomNavBarIcon(selected: (index == currentIndex));
    }
    return Container();
  }
}
