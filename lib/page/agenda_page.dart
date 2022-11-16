import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/others/date_shrink.dart';
import 'package:oloid2/others/month_to_string.dart';
import 'package:oloid2/others/weekday_to_string.dart';
import 'package:oloid2/states/agenda/agenda_bloc.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/agenda/event.dart';
import 'package:oloid2/widget/agenda/mini_calendar.dart';
import 'package:oloid2/widget/custom_circular_progress_indicator.dart';
import 'package:oloid2/widget/loading_snakbar.dart';
import 'package:oloid2/widget/settings/agenda_url_params.dart';
import 'package:oloid2/widget/settings_card.dart';
import 'package:sizer/sizer.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<AgendaBloc>().state is AgendaInitial) {
      context.read<AgendaBloc>().add(AgendaLoad(
          context.read<AuthentificationBloc>().dartus!,
          context.read<SettingsBloc>().state.settings));
    }
    return BlocListener<SettingsBloc, SettingsState>(
        listenWhen: (previous, current) =>
            previous.settings.agendaURL != current.settings.agendaURL ||
            previous.settings.fetchAgendaAuto !=
                current.settings.fetchAgendaAuto,
        listener: (context, state) {
          context.read<AgendaBloc>().add(AgendaLoad(
              context.read<AuthentificationBloc>().dartus!,
              context.read<SettingsBloc>().state.settings));
        },
        child: BlocConsumer<AgendaBloc, AgendaState>(
          listener: (context, state) {
            if (state is AgendaLoading) {
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar(
                      message: "Chargement de l'agenda", context: context)));
            } else if (state is AgendaReady || state is AgendaError) {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
            }
          },
          builder: (context, state) {
            if (state is AgendaError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Erreur lors du chargement de l'agenda\nEssayez de désactiver la récuperation automatique de l'agenda dans les paramètres",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SettingsCard(
                          name: "Paramètres de l'agenda",
                          widgets: [AgendaUrlParams()]),
                    ],
                  ),
                ),
              );
            } else if (state is AgendaLoading || state is AgendaInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomCircularProgressIndicator(),
                    SizedBox(height: 1.h),
                    const Text("Chargement de l'agenda"),
                  ],
                ),
              );
            } else {
              return const AgendaWrapped();
            }
          },
        ));
  }
}

class AgendaWrapped extends StatelessWidget {
  const AgendaWrapped({Key? key}) : super(key: key);

  static double indexToOffset(int index) {
    return (15.w) * (index);
  }

  @override
  Widget build(BuildContext context) {
    bool animating = false;
    PageController pageController = PageController();
    ScrollController scrollController = ScrollController(
        initialScrollOffset: indexToOffset(context
            .read<AgendaBloc>()
            .wantedDate
            .shrink(3)
            .difference(DateTime.now().shrink(3))
            .inDays));

    pageController = PageController(
        initialPage: context.read<AgendaBloc>().dayModels.indexWhere(
            (element) =>
                element.date.shrink(3) ==
                context.read<AgendaBloc>().wantedDate.shrink(3)));

    return BlocListener<AgendaBloc, AgendaState>(
        listener: (context, state) {
          if (scrollController.hasClients && pageController.hasClients) {
            final int pageIndex = context
                .read<AgendaBloc>()
                .dayModels
                .indexWhere((element) =>
                    element.date.shrink(3) ==
                    context.read<AgendaBloc>().wantedDate.shrink(3));
            if (!animating) {
              pageController.animateToPage(
                pageIndex,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
              );
              scrollController.animateTo(
                  indexToOffset(context
                      .read<AgendaBloc>()
                      .wantedDate
                      .shrink(3)
                      .difference(DateTime.now().shrink(3))
                      .inDays),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }
            if (pageIndex != pageController.page) {
              animating = true;
              Future.delayed(const Duration(milliseconds: 500), () {
                animating = false;
                scrollController.animateTo(
                    indexToOffset(context
                        .read<AgendaBloc>()
                        .wantedDate
                        .shrink(3)
                        .difference(DateTime.now().shrink(3))
                        .inDays),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              });
            }
          }
        },
        child: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: RefreshIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context.read<SettingsBloc>().state.settings.showMiniCalendar
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
                            .state
                            .settings
                            .showMiniCalendar) {
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
                                              '${day.events.length} évènement(s)'),
                                        ]),
                                  ),
                                  ...day.events.map(
                                    (e) => Event(
                                      event: e,
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
                    context.read<SettingsBloc>().state.settings));
                while (context.read<AgendaBloc>().state is! AgendaReady &&
                    context.read<AgendaBloc>().state is! AgendaError) {
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                return;
              },
            ),
          ),
        ));
  }
}
