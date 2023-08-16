import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/widgets/common_screen_widget.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/widgets/states_displaying/state_displaying_widget_export.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({
    Key? key,
  }) : super(key: key);

  static double indexToOffset(int index) {
    return (15.w) * (index);
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<AgendaCubit>().state.status == AgendaStatus.initial) {
      context.read<AgendaCubit>().load(
          lyon1Cas: context.read<AuthentificationCubit>().state.lyon1Cas,
          settings: context.read<SettingsCubit>().state.settings);
    }
    return BlocBuilder<AgendaCubit, AgendaState>(
        buildWhen: (previous, current) =>
            previous.status != AgendaStatus.dateUpdated,
        builder: (context, state) {
          if (kDebugMode) {
            print("AgendaState: ${state.status}");
          }
          Widget? headerState;
          switch (state.status) {
            case AgendaStatus.initial:
            case AgendaStatus.loading:
            case AgendaStatus.cacheReady:
              headerState =
                  const LoadingHeaderWidget(message: "Chargement de l'agenda");
              break;
            case AgendaStatus.ready:
              break;
            case AgendaStatus.dateUpdated:
              break;
            case AgendaStatus.error:
              headerState = const LoadingHeaderWidget(
                  message: "Erreur lors du chargement de l'agenda");
              break;
            case AgendaStatus.haveToChooseManualy:
              return AgendaConfigPage(
                onBack: (int agendaId) {
                  context.read<SettingsCubit>().modify(
                        settings: context
                            .read<SettingsCubit>()
                            .state
                            .settings
                            .copyWith(
                              agendaId: agendaId,
                              fetchAgendaAuto: false,
                            ),
                      );
                },
              );
          }
          bool animating = false;
          PageController pageController = PageController();
          ScrollController scrollController = ScrollController(
              initialScrollOffset: indexToOffset(state.wantedDate
                  .shrink(3)
                  .difference(DateTime.now().shrink(3))
                  .inDays));

          pageController = PageController(
              initialPage: state.days.indexWhere((element) =>
                  element.date.shrink(3) ==
                  context.read<AgendaCubit>().state.wantedDate.shrink(3)));
          return BlocListener<AgendaCubit, AgendaState>(
            listenWhen: (previous, current) {
              return current.status == AgendaStatus.dateUpdated;
            },
            listener: (context, state) {
              if (scrollController.hasClients && pageController.hasClients) {
                final int pageIndex = state.days.indexWhere((element) =>
                    element.date.shrink(3) == state.wantedDate.shrink(3));
                if (!state.dateUpdateFromPageController) {
                  animating = true;
                }
                pageController
                    .animateToPage(
                  pageIndex,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                )
                    .then((value) {
                  animating = false;
                });
                scrollController.animateTo(
                    indexToOffset((state.wantedDate
                                .shrink(3)
                                .difference(DateTime.now().shrink(3))
                                .inHours /
                            24)
                        .round()),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
            },
            child: CommonScreenWidget(
              state: headerState,
              header: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .showMiniCalendar
                  ? MiniCalendarWidget(
                      scrollController: scrollController,
                      onUpdate: (DateTime newWantedDay) {
                        context.read<AgendaCubit>().updateDisplayedDate(
                            date: newWantedDay, fromPageController: false);
                      },
                    )
                  : Center(
                      child: Text(
                        'Agenda',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              body: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                key: UniqueKey(),
                // pas le plus propre mais force a rebuild et reinit le controller
                onPageChanged: (index) {
                  if (context
                          .read<SettingsCubit>()
                          .state
                          .settings
                          .showMiniCalendar &&
                      !animating) {
                    if (context.read<AgendaCubit>().state.days.length > index) {
                      context.read<AgendaCubit>().updateDisplayedDate(
                          date: context
                              .read<AgendaCubit>()
                              .state
                              .days[index]
                              .date,
                          fromPageController: true);
                    }
                  }
                },
                children: context
                    .read<AgendaCubit>()
                    .state
                    .days
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
                                              .bodyLarge!
                                              .color),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text('${day.events.length} événement(s)'),
                                  ]),
                            ),
                            ...day.events.map(
                              (e) => EventWidget(
                                event: e,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    )
                    .toList(),
              ),
              onRefresh: () async {
                context.read<AgendaCubit>().load(
                    lyon1Cas:
                        context.read<AuthentificationCubit>().state.lyon1Cas,
                    settings: context.read<SettingsCubit>().state.settings);
                while (context.read<AgendaCubit>().state.status !=
                        AgendaStatus.ready &&
                    context.read<AgendaCubit>().state.status !=
                        AgendaStatus.error) {
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                return;
              },
            ),
          );
        });
  }
}
