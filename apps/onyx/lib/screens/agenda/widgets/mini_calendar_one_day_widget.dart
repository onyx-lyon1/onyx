import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget_res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MiniCalendarOneDayWidget extends StatelessWidget {
  const MiniCalendarOneDayWidget({
    super.key,
    required this.context,
    required this.currentDateIndex,
  });

  final BuildContext context;
  final int currentDateIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaCubit, AgendaState>(
      buildWhen: (previous, current) {
        if (previous.days.length > previous.wantedDate &&
            current.days.length > current.wantedDate) {
          return (previous.days[previous.wantedDate].date
                      .isSameDay(current.days[currentDateIndex].date) ||
                  current.days[current.wantedDate].date
                      .isSameDay(current.days[currentDateIndex].date)) &&
              (!context.read<AgendaCubit>().blockMiniCalendar);
        }
        return true;
      },
      builder: (context, state) {
        return SizedBox(
          key: Key(state.days[currentDateIndex].date.shrink(3).toString()),
          height: Res.bottomNavBarHeight,
          width: (100 - DaysViewRes.leftHourIndicatorWidth).w /
              context.read<SettingsCubit>().state.settings.agendaWeekLength,
          child: Padding(
            padding: EdgeInsets.all(0.5.w),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (state.days[state.wantedDate].date.day ==
                              state.days[currentDateIndex].date.day &&
                          state.days[state.wantedDate].date.month ==
                              state.days[currentDateIndex].date.month)
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (DateTime.now()
                            .isSameDay(state.days[currentDateIndex].date))
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    width: 0.5.w,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    context.read<AgendaCubit>().updateDisplayedDate(
                        wantedDate: currentDateIndex,
                        fromMiniCalendar: true,
                        settings: context.read<SettingsCubit>().state.settings,
                        fromHorizontalScroll: false);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 2.9.h,
                        child: Text(
                          state.days[currentDateIndex].date.toMonthName(
                              AppLocalizations.of(context)!.localeName,
                              short: true),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                        child: Text(
                          state.days[currentDateIndex].date.day.toString(),
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                        child: Text(
                          state.days[currentDateIndex].date.toWeekDayName(
                              AppLocalizations.of(context)!.localeName,
                              short: true),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
