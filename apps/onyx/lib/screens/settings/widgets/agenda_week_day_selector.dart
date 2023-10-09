import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/date_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaWeekDaySelector extends StatelessWidget {
  const AgendaWeekDaySelector(
      {Key? key, required this.colorCondition, required this.onTap})
      : super(key: key);

  final bool Function(int) colorCondition;
  final Function(int) onTap;

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
                    : Theme.of(context).cardColor,
                child: InkWell(
                  onTap: () => onTap(i),
                  child: Center(child: Text(weekDaysShort[i])),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
