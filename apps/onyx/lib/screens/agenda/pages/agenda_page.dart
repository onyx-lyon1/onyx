import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({
    super.key,
  });

  static double indexToOffset(int index, int daycount) {
    return 15.w * index;
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>().settings;
    int wantedDate = context.read<AgendaCubit>().state.wantedDate;
    int weekLength = settings.agendaWeekLength;
    context.read<AgendaCubit>().miniCalendarScrollController =
        PageController(initialPage: wantedDate ~/ weekLength);
    context.read<AgendaCubit>().horizontalScrollController[0] =
        PageController(initialPage: wantedDate);
    context.read<AgendaCubit>().horizontalScrollController[1] =
        PageController(initialPage: wantedDate ~/ weekLength);

    return BlocBuilder<AgendaCubit, AgendaState>(
      buildWhen: (previous, current) =>
          current.status != AgendaStatus.dateUpdated &&
          current.status != AgendaStatus.updateAnimating,
      builder: (context, state) {
        Widget? headerState;
        switch (state.status) {
          case AgendaStatus.initial:
            context.read<AgendaCubit>().load(
                lyon1Cas: context.read<AuthCubit>().state.lyon1Cas,
                settings: settings);
            break;
          case AgendaStatus.connecting:
            headerState = LoadingHeaderWidget(
                message: AppLocalizations.of(context).connecting);
            break;
          case AgendaStatus.loading:
          case AgendaStatus.cacheReady:
            headerState = LoadingHeaderWidget(
                message: AppLocalizations.of(context).loadingAgenda);
            break;
          case AgendaStatus.error:
            headerState = LoadingHeaderWidget(
                message: AppLocalizations.of(context).agendaError);
            break;
          case AgendaStatus.haveToChooseManualy:
            return AgendaConfigPage(
              noBack: true,
              onBack: (List<int> agendaIds) {
                context.read<SettingsCubit>().modify(
                      settings: settings.copyWith(
                        agendaIds: agendaIds,
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
          header: Stack(
            alignment: Alignment.centerRight,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      context.read<AgendaCubit>().goToday(
                            fromMiniCalendar: false,
                            settings: settings,
                            fromHorizontalScroll: false,
                          );
                    },
                    icon: const Icon(Icons.calendar_today_rounded)),
              ),
              if (settings.showMiniCalendar)
                SizedBox(
                  width: 90.w,
                  child: MiniCalendarWidget(
                    scrollController: context
                        .read<AgendaCubit>()
                        .miniCalendarScrollController,
                  ),
                )
              else
                Center(
                  child: Text(
                    AppLocalizations.of(context).agenda,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          body: MultiScrollableWidget(
            listScrollController: verticalController,
            pageController:
                context.read<AgendaCubit>().verticalScrollController,
            child: PageView(
              controller: context.read<AgendaCubit>().verticalScrollController,
              scrollDirection: Axis.vertical,
              reverse: settings.agendaPageTopToBottom,
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
                    int date = context.read<AgendaCubit>().state.wantedDate;
                    context
                        .read<AgendaCubit>()
                        .horizontalScrollController[1]
                        .jumpToPage(date ~/ settings.agendaWeekLength);
                    context.read<AgendaCubit>().updateDisplayedDate(
                        wantedDate: date,
                        fromMiniCalendar: false,
                        fromHorizontalScroll: true,
                        settings: settings);
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
                    dayCount: settings.agendaWeekLength,
                    verticalController: verticalController[1],
                    horizontalController: context
                        .read<AgendaCubit>()
                        .horizontalScrollController[1]),
                Center(
                  child: Text(AppLocalizations.of(context).monthViewSoon),
                )
              ],
            ),
          ),
          onRefresh: () async {
            context.read<AgendaCubit>().load(
                  lyon1Cas: context.read<AuthCubit>().state.lyon1Cas,
                  settings: settings,
                  fromUser: true,
                  cache: false,
                );

            while (state.status != AgendaStatus.ready &&
                state.status != AgendaStatus.error) {
              await Future.delayed(const Duration(milliseconds: 100));
            }
            return;
          },
        );
      },
    );
  }
}
