import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget_res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DaysViewWidget extends StatelessWidget {
  const DaysViewWidget(
      {Key? key,
      required this.dayCount,
      required this.verticalController,
      required this.horizontalController})
      : super(key: key);

  final int dayCount;
  final ScrollController verticalController;
  final PageController horizontalController;

  @override
  Widget build(BuildContext context) {
    var agendaState = context.read<AgendaCubit>().state;

    double columnWidth =
        (100 - DaysViewRes.leftHourIndicatorWidth).w / dayCount;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      controller: verticalController,
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          GridWidget(
            columnWidth: columnWidth,
            dayCount: dayCount,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LeftHourIndicatorWidget(),
              SizedBox(
                width: (100 - DaysViewRes.leftHourIndicatorWidth).w,
                height:
                    (Res.agendaDayDuration.inHours / DaysViewRes.heightFactor)
                            .h *
                        (Res.agendaDayDuration.inHours - 1),
                child: PageView.builder(
                  controller: horizontalController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    context.read<AgendaCubit>().updateDisplayedDate(
                        wantedDate: index * dayCount, fromMiniCalendar: false);
                  },
                  itemBuilder: (context, j) {
                    if (j + dayCount < agendaState.days.length) {
                      return Row(
                        children: [
                          for (var i = 0; i < dayCount; i++)
                            Column(
                              children: [
                                ...buildEventWidgetList(
                                  agendaState.days[j + i].events,
                                  columnWidth,
                                )
                              ],
                            ),
                        ],
                      );
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> buildEventWidgetList(List<Event> events, double columnWidth) {
    List<Widget> result = [];
    Map<int, List<int>> superposition = {};

    //construct superposition map
    for (int index = 0; index < events.length - 1; index++) {
      if (events[index].end.isAfter(events[index + 1].start)) {
        //there is one superposition
        bool found = false;
        for (var sup in superposition.keys) {
          if (superposition[sup]!.contains(index)) {
            superposition[sup]!.add(index + 1);
            found = true;
          }
        }
        if (!found) {
          superposition[index] = [index, index + 1];
        }
      }
    }

    for (int index = 0; index < events.length - 1; index++) {
      double diff = 0.0;
      Map<int, double> diffMap = {};
      bool superposed = superposition.keys.contains(index);
      if (superposed) {
        for (int j = 0; j < superposition[index]!.length; j++) {
          diffMap[superposition[index]![j]] = getDiff(
              events[superposition[index]![j]],
              //if we have to compare to the previous event in the calendar
              (j == 0)
                  //if there is a previous one
                  ? ((index > 0) ? events[index - 1] : null)
                  : events[superposition[index]![j - 1]]);
        }
        diff = diffMap[superposition[index]!.first]!;
      } else {
        diff = getDiff(events[index], (index > 0) ? events[index - 1] : null);
      }
      result.add(
        Padding(
          padding: EdgeInsets.only(
            top: (diff *
                        (Res.agendaDayDuration.inHours /
                                DaysViewRes.heightFactor)
                            .h -
                    0.5.h)
                .clamp(0, double.infinity),
          ),
          child: (superposed)
              ? Row(
                  children: [
                    for (var i in superposition[index]!)
                      Padding(
                        padding: EdgeInsets.only(
                          top: (superposition[index]!.first != i)
                              ? (diffMap[i]! *
                                          (Res.agendaDayDuration.inHours /
                                                  DaysViewRes.heightFactor)
                                              .h -
                                      0.5.h)
                                  .clamp(0, double.infinity)
                              : 0.0,
                        ),
                        child: SizedEventWidget(
                            heightFactor: DaysViewRes.heightFactor,
                            numberPerColumn:
                                (superposition[index]?.length) ?? 1,
                            columnWidth: columnWidth,
                            event: events[i]),
                      ),
                  ],
                )
              : SizedEventWidget(
                  heightFactor: DaysViewRes.heightFactor,
                  numberPerColumn: 1,
                  columnWidth: columnWidth,
                  event: events[index]),
        ),
      );
      if (superposed) {
//-1 because the for loop will add it
        index += superposition[index]!.length - 1;
      }
    }

    return result;
  }

  double getDiff(Event a, Event? b) {
    if (b != null) {
      return a.start.difference(b.end).inMinutes / 60;
    } else {
      return a.start
              .difference(DateTime(a.start.year, a.start.month, a.start.day,
                  Res.agendaDayStart.inHours))
              .inMinutes /
          60;
    }
  }
}
