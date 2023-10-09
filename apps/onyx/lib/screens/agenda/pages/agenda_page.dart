import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/widgets/common_screen_widget.dart';
import 'package:onyx/core/widgets/no_border_slider_shape.dart';
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
            case AgendaStatus.error:
              headerState = const LoadingHeaderWidget(
                  message: "Erreur lors du chargement de l'agenda");
              break;
            case AgendaStatus.haveToChooseManualy:
              return AgendaConfigPage(
                noBack: true,
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
            case AgendaStatus.ready:
              break;
            case AgendaStatus.dateUpdated:
              break;
            case AgendaStatus.updateDayCount:
              break;
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
              body: Column(
                children: [
                  Flexible(
                    flex: 30,
                    child: (context.read<AgendaCubit>().state.dayCount <= 1)
                        ? OneDayView(
                            animating: animating,
                            pageController: pageController,
                          )
                        : MultipleDayView(
                            animating: animating,
                            pageController: pageController,
                          ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Spacer(),
                            SliderTheme(
                              data: SliderThemeData(
                                // here
                                trackShape: CustomTrackShape(),
                              ),
                              child: Flexible(
                                flex: 50,
                                child: Slider(
                                  min: 1,
                                  max: 14,
                                  value: context
                                      .read<AgendaCubit>()
                                      .state
                                      .dayCount
                                      .toDouble(),
                                  onChanged: (newValue) => context
                                      .read<AgendaCubit>()
                                      .updateDayCount(newValue.toInt()),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                                flex: 20,
                                child: Text(
                                    "${context.read<AgendaCubit>().state.dayCount} jours")),
                            const Spacer(),
                          ],
                        ),
                      )),
                ],
              ),
              onRefresh: () async {
                context.read<AgendaCubit>().load(
                      lyon1Cas:
                          context.read<AuthentificationCubit>().state.lyon1Cas,
                      settings: context.read<SettingsCubit>().state.settings,
                    );
                // ignore: use_build_context_synchronously
                while (context.read<AgendaCubit>().state.status !=
                        AgendaStatus.ready &&
                    // ignore: use_build_context_synchronously
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
