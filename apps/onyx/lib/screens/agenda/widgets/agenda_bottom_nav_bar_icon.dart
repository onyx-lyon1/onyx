import 'package:flutter/material.dart';

class AgendaBottomNavBarIcon extends StatelessWidget {
  const AgendaBottomNavBarIcon({Key? key, required this.selected})
      : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          SizedBox(
            child: FittedBox(
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
                // size: 30.sp,
              ),
            ),
          ),
          Positioned(
            top: ((1 / 3) * constraints.maxHeight) * 0.5,
            child: SizedBox(
              height: ((2 / 3) * constraints.maxHeight) * 1.2,
              child: FittedBox(
                fit: BoxFit.fitHeight,
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
                      ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
