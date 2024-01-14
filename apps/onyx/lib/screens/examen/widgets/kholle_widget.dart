import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class KholleWidget extends StatelessWidget {
  const KholleWidget({
    super.key,
    required this.kholle,
  });

  final Kholle kholle;

  @override
  Widget build(BuildContext context) {
    var isToday = kholle.date.isSameDay(DateTime.now());

    return Container(
      height: 13.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: (isToday) ? 1.5 : 3,
                      ),
                      color: (isToday)
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                    height: constraints.maxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kholle.date.toMonthName(short: true),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                        Text(
                          kholle.date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          kholle.date.toWeekDayName(short: false),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: EdgeInsets.only(left: constraints.maxWidth * 0.02),
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.02),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text(
                              kholle.date.toHourMinuteString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 2,
                          height: constraints.maxHeight * 0.65,
                          color: /*Theme.of(context).colorScheme.background*/
                              Colors.black38,
                        ),
                        Flexible(
                            flex: 7,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kholle.subject),
                                  Text(kholle.kholleur),
                                  if (kholle.message != null)
                                    Text(kholle.room ?? kholle.message!),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // child: child,
    );
  }
}
