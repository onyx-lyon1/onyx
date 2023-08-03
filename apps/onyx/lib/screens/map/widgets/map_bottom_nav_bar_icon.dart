import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MapBottomNavBarIcon extends StatelessWidget {
  const MapBottomNavBarIcon({Key? key, required this.selected})
      : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.map_rounded,
      color: selected
          ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
          : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      size: 30.sp,
    );
  }
}
