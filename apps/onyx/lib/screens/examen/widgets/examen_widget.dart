import 'package:flutter/material.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExamenWidget extends StatelessWidget {
  const ExamenWidget({
    super.key,
    required this.examen,
  });

  final ExamenModel examen;

  @override
  Widget build(BuildContext context) {
    var isToday = examen.date.isSameDay(DateTime.now());

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
                          examen.date.toMonthName(
                              AppLocalizations.of(context)!.localeName,
                              short: true),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                        Text(
                          examen.date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          examen.date.toWeekDayName(
                              AppLocalizations.of(context)!.localeName,
                              short: false),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  examen.date.toHourMinuteString(
                                      AppLocalizations.of(context)!.localeName),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              Text(examen.duration.durationBeautifull()),
                            ],
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
                                  Text(
                                    examen.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .examLocationPlace(
                                            examen.location, examen.place),
                                  ),
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
