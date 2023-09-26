import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MultipleDayViewWidget extends StatelessWidget {
  final PageController pageController;

  const MultipleDayViewWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  static const double heightFactor = 3.0;
  static const double leftHourIndicatorWidth = 10.0;

  @override
  Widget build(BuildContext context) {
    final AgendaState agendaState = context.read<AgendaCubit>().state;
    final double columnWidth =
        (100 - leftHourIndicatorWidth).w / agendaState.dayCount;

    return PageView(
      controller: pageController,
      scrollDirection: Axis.vertical,
      key: UniqueKey(),
      // pas le plus propre mais force a rebuild et reinit le controller
      onPageChanged: (index) {
        if (context.read<SettingsCubit>().state.settings.showMiniCalendar &&
            !agendaState.animating) {
          if (agendaState.days.length > index) {
            context.read<AgendaCubit>().updateDisplayedDate(
                date: agendaState.days[index].date, fromPageController: true);
          }
        }
      },
      children: [
        for (int i = 0;
            i < agendaState.days.length;
            i = i + agendaState.dayCount)
          SingleChildScrollView(
            child: Stack(
              // alignment: Alignment.center,
              children: [
                GridWidget(
                  heightFactor: heightFactor,
                  leftHourIndicatorWidth: leftHourIndicatorWidth,
                  columnWidth: columnWidth,
                ),
                Row(
                  children: [
                    //left hour indicator
                    const LeftHourIndicatorWidget(
                        heightFactor: heightFactor,
                        leftHourIndicatorWidth: leftHourIndicatorWidth),
                    for (int j = 0;
                        j < agendaState.dayCount &&
                            i + j < agendaState.days.length;
                        j++)
                      SizedBox(
                        width: columnWidth,
                        height:
                            (Res.agendaDayDuration.inHours / heightFactor).h *
                                (Res.agendaDayDuration.inHours - 1),
                        child: Column(
                          children: buildEventWidgetList(
                            agendaState.days[i + j].events,
                            columnWidth,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
      ],
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
            top: (diff * (Res.agendaDayDuration.inHours / heightFactor).h -
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
                                                  heightFactor)
                                              .h -
                                      0.5.h)
                                  .clamp(0, double.infinity)
                              : 0.0,
                        ),
                        child: SizedEventWidget(
                            heightFactor: heightFactor,
                            numberPerColumn:
                                (superposition[index]?.length) ?? 1,
                            columnWidth: columnWidth,
                            event: events[i]),
                      ),
                  ],
                )
              : SizedEventWidget(
                  heightFactor: heightFactor,
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
