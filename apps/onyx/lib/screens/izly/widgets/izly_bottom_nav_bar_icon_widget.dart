import 'package:flutter/material.dart';

class IzlyBottomNavBarIconWidget extends StatelessWidget {
  const IzlyBottomNavBarIconWidget({super.key, required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Icon(
        Icons.attach_money_rounded,
        color: selected
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }
}
