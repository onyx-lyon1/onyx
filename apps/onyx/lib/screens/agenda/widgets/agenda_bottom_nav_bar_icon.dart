import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaBottomNavBarIcon extends StatelessWidget {
  const AgendaBottomNavBarIcon({super.key, required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: [
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Icon(
                    Icons.calendar_today_rounded,
                    color: selected
                        ? Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor
                        : Theme.of(context)
                            .bottomNavigationBarTheme
                            .unselectedItemColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.7.h),
                  child: Text(
                    DateTime.now().day.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: (selected)
                              ? Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .selectedItemColor
                              : Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                          // ),
                          fontSize: 14.sp,
                        ),
                  ),
                ),
              ],
            );
          }),
          Text(
            "Agenda",
            style: TextStyle(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
