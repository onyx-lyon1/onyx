import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyBottomNavBarIcon extends StatelessWidget {
  const IzlyBottomNavBarIcon({super.key, required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          Icon(
            Icons.attach_money_rounded,
            color: selected
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                : Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
          ),
          Text(
            "Izly",
            style: TextStyle(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
