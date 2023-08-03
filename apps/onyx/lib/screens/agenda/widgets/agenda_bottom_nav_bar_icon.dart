import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AgendaBottomNavBarIcon extends StatelessWidget {
  const AgendaBottomNavBarIcon({Key? key, required this.selected})
      : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.calendar_today_rounded,
          color: selected
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          size: 30.sp,
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.sp / 4),
          child: Text(
            DateTime.now().day.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15.sp,
                  color: (selected)
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                ),
          ),
        ),
      ],
    );
  }
}
