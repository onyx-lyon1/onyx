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

  static double indexToOffset(int index, int daycount) {
    return (15.w) * ((index / daycount) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaCubit, AgendaState>(
        buildWhen: (previous, current) =>
            current.status != AgendaStatus.dateUpdated &&
            current.status != AgendaStatus.updateAnimating,
        builder: (context, state) {
          if (kDebugMode) {
            print("AgendaState: ${state.status}");
          }
          Widget? headerState;
          switch (state.status) {
            case AgendaStatus.initial:
              context.read<AgendaCubit>().load(
                  lyon1Cas:
                      context.read<AuthentificationCubit>().state.lyon1Cas,
                  settings: context.read<SettingsCubit>().state.settings);
              break;
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
            case AgendaStatus.updateAnimating:
              break;
          }
          PageController pageController = PageController();
          ScrollController scrollController = ScrollController(
              initialScrollOffset: indexToOffset(
                  state.wantedDate
                      .shrink(3)
                      .difference(DateTime.now().shrink(3))
                      .inDays,
                  state.dayCount));

          pageController = PageController(
              initialPage: state.days.indexWhere((element) =>
                  element.date.shrink(3) == state.wantedDate.shrink(3)));
          return BlocListener<AgendaCubit, AgendaState>(
            listenWhen: (previous, current) {
              return current.status == AgendaStatus.dateUpdated ||
                  current.status == AgendaStatus.updateAnimating;
            },
            listener: (context, state) {
              if (kDebugMode) {
                print("AgendaState: ${state.status}");
              }
              if (scrollController.hasClients && pageController.hasClients) {
                int pageIndex = state.days.indexWhere((element) =>
                    element.date.shrink(3) == state.wantedDate.shrink(3));
                pageIndex = (pageIndex / state.dayCount - 0.5).ceil();
                if (!state.dateUpdateFromPageController) {
                  context.read<AgendaCubit>().updateAnimating(true);
                }
                pageController
                    .animateToPage(
                  pageIndex,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                )
                    .then((value) {
                  context.read<AgendaCubit>().updateAnimating(false);
                });
                scrollController.animateTo(
                    indexToOffset(
                        (state.wantedDate
                                    .shrink(3)
                                    .difference(DateTime.now().shrink(3))
                                    .inHours /
                                24)
                            .round(),
                        state.dayCount),
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
                    child: (state.dayCount <= 1)
                        ? OneDayViewWidget(pageController: pageController)
                        : MultipleDayViewWidget(pageController: pageController),
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
                                child: Text("${state.dayCount} jours")),
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
                while (state.status != AgendaStatus.ready &&
                    // ignore: use_build_context_synchronously
                    state.status != AgendaStatus.error) {
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                return;
              },
            ),
          );
        });
  }
}
