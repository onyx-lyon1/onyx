import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/multiple_day_view/multiple_day_view_res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MultipleDayViewPageView extends StatelessWidget {
  const MultipleDayViewPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var agendaState = context.read<AgendaCubit>().state;
    MultipleDayViewRes.columnWidth =
        (100 - MultipleDayViewRes.leftHourIndicatorWidth).w /
            agendaState.dayCount;
    PageController pageController = PageController(
        initialPage: agendaState.days.indexWhere((element) =>
            element.date.shrink(3) == agendaState.wantedDate.shrink(3)));
    Map<int, ScrollController> horizontalControllers = {};
    return BlocListener<AgendaCubit, AgendaState>(
      listenWhen: (previous, current) =>
          current.status == AgendaStatus.dateUpdated,
      listener: (context, state) {
        agendaState = context.read<AgendaCubit>().state;
        if (pageController.hasClients) {
          int dayIndex = agendaState.days.indexWhere((element) =>
              element.date.shrink(3) == agendaState.wantedDate.shrink(3));
          int pageIndex = (dayIndex / agendaState.dayCount).round();
          // pageController
          //     .animateToPage(
          //   pageIndex,
          //   curve: Curves.easeInOut,
          //   duration: const Duration(milliseconds: 500),
          // )
          //     .then((value) {
          //   context.read<AgendaCubit>().animating = false;
          // });
        }
      },
      child: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.vertical,
        key: UniqueKey(),
        // pas le plus propre mais force a rebuild et reinit le controller
        onPageChanged: (index) {
          print(!context.read<AgendaCubit>().animating);
          // if (
          //     // context.read<SettingsCubit>().state.settings.showMiniCalendar &&
          //     !context.read<AgendaCubit>().animating) {
          //   if (agendaState.days.length > index) {
          //     print("update page");
          //     int dayIndex = agendaState.days.indexWhere((element) =>
          //         element.date.shrink(3) == agendaState.wantedDate.shrink(3));
          //     if (dayIndex != -1) {
          //       int addition = index - dayIndex;
          //       DateTime date = agendaState.wantedDate
          //           .add(Duration(days: addition * agendaState.dayCount));
          //       context.read<AgendaCubit>().animating = false;
          //       context.read<AgendaCubit>().updateDisplayedDate(date: date);
          //     }
          //   }
          // }
        },
        itemBuilder: (context, rawi) {
          int i = rawi * agendaState.dayCount;
          if (i >= agendaState.days.length) {
            return null;
          }

          horizontalControllers[rawi] = ScrollController(
              initialScrollOffset: MultipleDayViewRes.columnWidth * i);
          return BlocListener<AgendaCubit, AgendaState>(
            listenWhen: (previous, current) =>
                current.status == AgendaStatus.dateUpdated,
            listener: (context, state) {
              if (horizontalControllers[rawi]!.hasClients) {
                int dayIndex = state.days.indexWhere((element) =>
                    element.date.shrink(3) == state.wantedDate.shrink(3));
                if (context.read<AgendaCubit>().animating) {
                  horizontalControllers[rawi]!
                      .animateTo(
                        MultipleDayViewRes.columnWidth * dayIndex,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500),
                      )
                      .then((value) =>
                          context.read<AgendaCubit>().animating = false);
                } else {
                  horizontalControllers[rawi]!.jumpTo(
                    MultipleDayViewRes.columnWidth * dayIndex,
                  );
                  context.read<AgendaCubit>().animating = false;
                }
                if (horizontalControllers[rawi - 1]!.hasClients) {
                  horizontalControllers[rawi - 1]!.jumpTo(
                      MultipleDayViewRes.columnWidth *
                          (dayIndex - state.dayCount));
                }
                if (horizontalControllers[rawi + 1]!.hasClients) {
                  horizontalControllers[rawi + 1]!.jumpTo(
                      MultipleDayViewRes.columnWidth *
                          (dayIndex + state.dayCount));
                }
              }
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MultipleDayViewRes.topDayIndicatorHeight.h),
                    child: const GridWidget(),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MultipleDayViewRes.leftHourIndicatorWidth.w,
                            height: MultipleDayViewRes.topDayIndicatorHeight.h,
                            child: Center(
                              child: Text(
                                "S: ${agendaState.days[i].date.toWeekNumber()}",
                              ),
                            ),
                          ),
                          const LeftHourIndicatorWidget(),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MultipleDayViewRes.columnWidth *
                                agendaState.dayCount,
                            height: (Res.agendaDayDuration.inHours /
                                            MultipleDayViewRes.heightFactor)
                                        .h *
                                    (Res.agendaDayDuration.inHours - 1) +
                                MultipleDayViewRes.topDayIndicatorHeight.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: horizontalControllers[rawi]!,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, rawIndex) {
                                int j = rawIndex - i;
                                if (j + i < agendaState.days.length) {
                                  return SizedBox(
                                    width: MultipleDayViewRes.columnWidth,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: MultipleDayViewRes.columnWidth,
                                          height: MultipleDayViewRes
                                              .topDayIndicatorHeight.h,
                                          child: Text(
                                            "${agendaState.days[i + j].date.toWeekDayName(short: true)}\n${agendaState.days[i + j].date.day}",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        ...buildEventWidgetList(
                                          agendaState.days[i + j].events,
                                          MultipleDayViewRes.columnWidth,
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return null;
                              },
//                               children: [
//                                 for (int j = -1;
//                                     j < agendaState.dayCount + 1 &&
//                                         i + j < agendaState.days.length &&
//                                         i + j > 0;
//                                     j++)
// ,
//                               ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    // }
    // ,
    //
    // );
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
                                MultipleDayViewRes.heightFactor)
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
                                                  MultipleDayViewRes
                                                      .heightFactor)
                                              .h -
                                      0.5.h)
                                  .clamp(0, double.infinity)
                              : 0.0,
                        ),
                        child: SizedEventWidget(
                            heightFactor: MultipleDayViewRes.heightFactor,
                            numberPerColumn:
                                (superposition[index]?.length) ?? 1,
                            columnWidth: columnWidth,
                            event: events[i]),
                      ),
                  ],
                )
              : SizedEventWidget(
                  heightFactor: MultipleDayViewRes.heightFactor,
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
