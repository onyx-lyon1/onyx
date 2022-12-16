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
    // return Text(index.toString());
    switch (index) {
      case 0:
        return BottomNavBarTomuss(
          selected: (index == currentIndex),
        );
      case 1:
        return BottomNavBarAgenda(selected: (index == currentIndex));
      case 2:
        return BottomNavBarEmail(selected: (index == currentIndex));
      case 3:
        return BottomNavBarSettings(selected: (index == currentIndex));
    }
    return Container();
  }
}
