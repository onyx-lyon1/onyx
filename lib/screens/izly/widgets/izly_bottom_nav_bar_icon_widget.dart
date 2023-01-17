import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IzlyBottomNavBarIconWidget extends StatelessWidget {
  const IzlyBottomNavBarIconWidget({Key? key, required this.selected})
      : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.attach_money_rounded,
      color: selected
          ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
          : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      size: 30.sp,
    );
  }
}
