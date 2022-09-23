import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/model/day.dart';
import 'package:oloid2/model/event.dart';
import 'package:oloid2/others/month_to_string.dart';
import 'package:oloid2/states/agenda/agenda_bloc.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/agenda/event.dart';
import 'package:oloid2/widget/custom_circular_progress_indicator.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AgendaPage extends StatelessWidget {
  final DatePickerController dateController = DatePickerController();
  PageController pageController = PageController();

  AgendaPage({
    Key? key,
  }) : super(key: key);

  void jumpToTop() {
    pageController.animateTo(
      0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void jumpToDate(DateTime date, List<DayModel> dayModels) {
    final int pageIndex = dayModels.indexWhere((element) =>
        element.date.year == date.year &&
        element.date.month == date.month &&
        element.date.day == date.day);
    pageController.animateToPage(
      pageIndex,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgendaBloc(),
      child: BlocBuilder<AgendaBloc, AgendaState>(
        builder: (context, state) {
          if (state is AgendaInitial) {
            context.read<AgendaBloc>().add(AgendaLoad(
                context.read<AuthentificationBloc>().dartus,
                context.read<SettingsBloc>().settings));
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomCircularProgressIndicator(),
                SizedBox(height: 1.h),
                const Text("Chargement de l'agenda"),
              ],
            ));
          } else if (state is AgendaInitialReady) {
            pageController = PageController(
                initialPage: context.read<AgendaBloc>().dayModels.indexWhere(
                    (element) =>
                        element.date.year == DateTime.now().year &&
                        element.date.month == DateTime.now().month &&
                        element.date.day == DateTime.now().day));
          } else if (state is AgendaError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Erreur lors du chargement de l'agenda\nEssayez de désactiver la récuperation automatique de l'agenda dans les paramètres",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            );
          }
          return Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.only(top: 27),
              child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    context.read<SettingsBloc>().settings.showMiniCalendar
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            color: Theme.of(context).cardTheme.color,
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: DateTime.now(),
                              daysCount: 180,
                              controller: dateController,
                              locale: 'fr_FR',
                              selectionColor: const Color(0xffd08770),
                              selectedTextColor: const Color(0xffe5e9f0),
                              monthTextStyle: const TextStyle(
                                  color: Color(0xffe5e9f0), fontSize: 9),
                              dayTextStyle: const TextStyle(
                                  color: Color(0xffe5e9f0), fontSize: 9),
                              dateTextStyle: const TextStyle(
                                  color: Color(0xffd8dee9), fontSize: 14),
                              onDateChange: (date) => jumpToDate(
                                  date, context.read<AgendaBloc>().dayModels),
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          if (context
                              .read<SettingsBloc>()
                              .settings
                              .showMiniCalendar) {
                            // dateController.animateToDate(
                            //   DateTime.now().add(Duration(days: index)),
                            // );
                          }
                        },
                        children: context
                            .read<AgendaBloc>()
                            .dayModels
                            .map(
                              (day) => SizedBox(
                                height: 10,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 15,
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${day.date.day} ${monthToString(day.date.month)}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color),
                                            ),
                                            Text(
                                                '${day.events.length} évènements'),
                                          ]),
                                    ),
                                    ...day.events.map(
                                      (e) => Event(
                                        event: e,
                                        onTap: (EventModel e) {},
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
                onRefresh: () async {
                  context.read<AgendaBloc>().add(AgendaLoad(
                      context.read<AuthentificationBloc>().dartus,
                      context.read<SettingsBloc>().settings));
                },
              ));
        },
      ),
    );
  }
}
