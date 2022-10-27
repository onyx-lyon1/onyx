import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/model/event_model.dart';
import 'package:oloid2/others/month_to_string.dart';
import 'package:oloid2/others/weekday_to_string.dart';
import 'package:oloid2/states/agenda/agenda_bloc.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/agenda/event.dart';
import 'package:oloid2/widget/agenda/mini_calendar.dart';
import 'package:oloid2/widget/custom_circular_progress_indicator.dart';
import 'package:oloid2/widget/loading_snakbar.dart';
import 'package:sizer/sizer.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AgendaBloc>().add(AgendaLoad(
        context.read<AuthentificationBloc>().dartus!,
        context.read<SettingsBloc>().settings));
    return BlocBuilder<AgendaBloc, AgendaState>(
      builder: (context, state) {
        if (state is AgendaInitial) {
          context.read<AgendaBloc>().add(AgendaLoad(
              context.read<AuthentificationBloc>().dartus!,
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
        } else if (state is AgendaLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              ScaffoldMessenger.of(context).showSnackBar(
                  loadingSnakbar(message: "agenda", context: context)));
        } else if (state is AgendaReady) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
        }
        return const AgendaWraped();
      },
    );
  }
}

class AgendaWraped extends StatelessWidget {
  const AgendaWraped({Key? key}) : super(key: key);

  static double indexToOffset(int index) {
    return (15.w) * index;
  }

  @override
  Widget build(BuildContext context) {
    bool animating = false;
    PageController pageController = PageController();
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0.0);

    pageController = PageController(
        initialPage: context.read<AgendaBloc>().dayModels.indexWhere(
            (element) =>
                element.date.year == DateTime.now().year &&
                element.date.month == DateTime.now().month &&
                element.date.day == DateTime.now().day));

    return BlocBuilder<AgendaBloc, AgendaState>(
      builder: (context, state) {
        if (scrollController.hasClients && pageController.hasClients) {
          final int pageIndex = context.read<AgendaBloc>().dayModels.indexWhere(
              (element) =>
                  element.date.year ==
                      context.read<AgendaBloc>().wantedDate.year &&
                  element.date.month ==
                      context.read<AgendaBloc>().wantedDate.month &&
                  element.date.day ==
                      context.read<AgendaBloc>().wantedDate.day);
          pageController.animateToPage(
            pageIndex,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
          );
          scrollController.animateTo(
              indexToOffset(context
                  .read<AgendaBloc>()
                  .wantedDate
                  .difference(DateTime.now())
                  .inDays),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
          if (pageIndex != pageController.page) {
            animating = true;
            Future.delayed(
                const Duration(milliseconds: 500), () => animating = false);
          }
        }

        return SafeArea(
          child: Container(
              color: Theme.of(context).backgroundColor,
              child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    context.read<SettingsBloc>().settings.showMiniCalendar
                        ? MiniCalendar(
                            scrollController: scrollController,
                            onUpdate: (DateTime newWantedDay) {
                              context
                                  .read<AgendaBloc>()
                                  .add(AgendaUpdateDisplayedDate(newWantedDay));
                            },
                            wantedDate: context.read<AgendaBloc>().wantedDate)
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
                            context.read<AgendaBloc>().add(
                                AgendaUpdateDisplayedDate(context
                                    .read<AgendaBloc>()
                                    .dayModels[index]
                                    .date));
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
                                              "${day.date.toWeekDayName()} ${day.date.day} ${day.date.toMonthName()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color),
                                              overflow: TextOverflow.ellipsis,
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
                      context.read<AuthentificationBloc>().dartus!,
                      context.read<SettingsBloc>().settings));
                  while (context.read<AgendaBloc>().state is! AgendaReady &&
                      context.read<AgendaBloc>().state is! AgendaError) {
                    await Future.delayed(const Duration(milliseconds: 100));
                  }
                  return;
                },
              )),
        );
      },
    );
  }
}
