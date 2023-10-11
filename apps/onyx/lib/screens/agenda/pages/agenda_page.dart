import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({
    Key? key,
  }) : super(key: key);

  static double indexToOffset(int index, int daycount) {
    return 15.w * index;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<AgendaCubit, AgendaState>(
            buildWhen: (previous, current) =>
                current.status != AgendaStatus.dateUpdated &&
                current.status != AgendaStatus.updateAnimating,
            builder: (context, state) {
              Widget? headerState;
              switch (state.status) {
                case AgendaStatus.initial:
                  context.read<AgendaCubit>().load(
                      lyon1Cas:
                          context.read<AuthentificationCubit>().state.lyon1Cas,
                      settings: settingsState.settings);
                  break;
                case AgendaStatus.loading:
                case AgendaStatus.cacheReady:
                  headerState = const LoadingHeaderWidget(
                      message: "Chargement de l'agenda");
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
                            settings: settingsState.settings.copyWith(
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

              List<ScrollController> verticalController =
                  List.generate(3, (_) => ScrollController());

              return CommonScreenWidget(
                state: headerState,
                header: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .showMiniCalendar
                    ? MiniCalendarWidget(
                        scrollController: context
                            .read<AgendaCubit>()
                            .miniCalendarScrollController,
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
                body: DoubleScrollableWidget(
                  listScrollController: verticalController,
                  pageController:
                      context.read<AgendaCubit>().verticalScrollController,
                  child: PageView(
                    controller:
                        context.read<AgendaCubit>().verticalScrollController,
                    scrollDirection: Axis.vertical,
                    reverse: settingsState.settings.agendaPageTopToBottom,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      if (index == 0) {
                        if (context
                            .read<AgendaCubit>()
                            .horizontalScrollController[0]
                            .hasClients) {
                          context
                              .read<AgendaCubit>()
                              .horizontalScrollController[0]
                              .jumpToPage(
                                  context.read<AgendaCubit>().state.wantedDate);
                        }
                      } else {
                        if (context
                            .read<AgendaCubit>()
                            .horizontalScrollController[1]
                            .hasClients) {
                          int date =
                              context.read<AgendaCubit>().state.wantedDate;
                          context
                              .read<AgendaCubit>()
                              .horizontalScrollController[1]
                              .jumpToPage(date ~/
                                  settingsState.settings.agendaWeekLength);
                          context.read<AgendaCubit>().updateDisplayedDate(
                              wantedDate: date,
                              fromMiniCalendar: false,
                              fromHorizontalScroll: true,
                              settings: settingsState.settings);
                        }
                      }
                    },
                    children: [
                      DaysViewWidget(
                          dayCount: 1,
                          verticalController: verticalController[0],
                          horizontalController: context
                              .read<AgendaCubit>()
                              .horizontalScrollController[0]),
                      DaysViewWidget(
                          dayCount: settingsState.settings.agendaWeekLength,
                          verticalController: verticalController[1],
                          horizontalController: context
                              .read<AgendaCubit>()
                              .horizontalScrollController[1]),
                      const Center(
                        child: Text("month view coming soon"),
                      )
                    ],
                  ),
                ),
                onRefresh: () async {
                  context.read<AgendaCubit>().load(
                        lyon1Cas: context
                            .read<AuthentificationCubit>()
                            .state
                            .lyon1Cas,
                        settings: settingsState.settings,
                        fromUser: true,
                        cache: false,
                      );
                  // ignore: use_build_context_synchronously
                  while (state.status != AgendaStatus.ready &&
                      // ignore: use_build_context_synchronously
                      state.status != AgendaStatus.error) {
                    await Future.delayed(const Duration(milliseconds: 100));
                  }
                  return;
                },
              );
            });
      },
    );
  }
}
