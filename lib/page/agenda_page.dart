import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/model/event_model.dart';
import 'package:oloid2/others/month_to_string.dart';
import 'package:oloid2/others/weekday_to_string.dart';
import 'package:oloid2/states/agenda/agenda_bloc.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/agenda/event.dart';
import 'package:oloid2/widget/custom_circular_progress_indicator.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AgendaPage extends StatelessWidget {
  const AgendaPage({
    Key? key,
  }) : super(key: key);

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
          return const AgendaWraped();
        },
      ),
    );
  }
}

class AgendaWraped extends StatefulWidget {
  const AgendaWraped({Key? key}) : super(key: key);

  @override
  State<AgendaWraped> createState() => _AgendaWrapedState();
}

class _AgendaWrapedState extends State<AgendaWraped> {
  PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  DateTime wantedDate = DateTime.now();
  bool animating = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: context.read<AgendaBloc>().dayModels.indexWhere(
            (element) =>
                element.date.year == DateTime.now().year &&
                element.date.month == DateTime.now().month &&
                element.date.day == DateTime.now().day));
  }

  static double indexToOffset(int index) {
    return (19.w * index) + 10;
  }

  @override
  Widget build(BuildContext context) {
    final int pageIndex = context.read<AgendaBloc>().dayModels.indexWhere(
        (element) =>
            element.date.year == wantedDate.year &&
            element.date.month == wantedDate.month &&
            element.date.day == wantedDate.day);
    pageController.animateToPage(
      pageIndex,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );

    scrollController.animateTo(
        indexToOffset(wantedDate.difference(DateTime.now()).inDays),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut);

    if (pageIndex != pageController.page) {
      animating = true;
      Future.delayed(
          const Duration(milliseconds: 500), () => animating = false);
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
                      height: 15.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                      ),
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        // cacheExtent: 0.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        itemCount: 25,
                        itemBuilder: (context, compteur) {
                          DateTime currentDate =
                              DateTime.now().add(Duration(days: compteur));
                          return Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: (wantedDate.day == currentDate.day)
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  setState(() {
                                    wantedDate = currentDate;
                                  });
                                },
                                child: SizedBox(
                                  height: 10.h,
                                  width: 15.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(monthToString(currentDate.month,
                                          short: true)),
                                      Text(currentDate.day.toString()),
                                      Text(weekdayToString(currentDate.weekday,
                                          short: true)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
                            .showMiniCalendar &&
                        !animating) {
                      setState(() {
                        wantedDate =
                            context.read<AgendaBloc>().dayModels[index].date;
                      });
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
                                      Text('${day.events.length} évènements'),
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
  }
}
