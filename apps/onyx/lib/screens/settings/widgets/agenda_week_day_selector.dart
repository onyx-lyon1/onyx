import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaWeekDaySelector extends StatelessWidget {
  const AgendaWeekDaySelector(
      {super.key,
      required this.colorCondition,
      required this.onTap,
      this.disabledCondition,
      required this.elements});

  final bool Function(int) colorCondition;
  final Function(int) onTap;

  final bool Function(int)? disabledCondition;

  final List<String> elements;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 7; i++)
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              height: 5.h,
              child: Material(
                color: colorCondition(i)
                    ? Theme.of(context).primaryColor
                    : (disabledCondition?.call(i) ?? false
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).cardColor),
                child: InkWell(
                  onTap: disabledCondition?.call(i) ?? false
                      ? null
                      : () => onTap(i),
                  child: Center(
                    child: Text(
                      elements[i],
                      style: TextStyle(
                          color: disabledCondition?.call(i) ?? false
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
