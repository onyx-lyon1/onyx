import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/extensions/date_extension.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MonthViewWidget extends StatefulWidget {
  const MonthViewWidget({super.key});

  @override
  State<MonthViewWidget> createState() => _MonthViewWidgetState();
}

class _MonthViewWidgetState extends State<MonthViewWidget> {
  late DateTime _currentMonth;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    final state = context.read<AgendaCubit>().state;
    if (state.days.isNotEmpty &&
        state.wantedDate >= 0 &&
        state.wantedDate < state.days.length) {
      _currentMonth = DateTime(
        state.days[state.wantedDate].date.year,
        state.days[state.wantedDate].date.month,
      );
      _selectedDay = state.days[state.wantedDate].date.shrink(3);
    } else {
      final now = DateTime.now();
      _currentMonth = DateTime(now.year, now.month);
      _selectedDay = now.shrink(3);
    }
  }

  int _getWeekReference() {
    final ref = context.read<SettingsCubit>().state.settings.agendaWeekReference;
    return ref == 8 ? DateTime.now().weekday - 1 : ref;
  }

  bool _isDayDisabled(int weekday) {
    return context
        .read<SettingsCubit>()
        .state
        .settings
        .agendaDisabledDays
        .contains(weekday);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _selectDay(DateTime day, List<Day> days) {
    setState(() {
      _selectedDay = day.shrink(3);
    });

    final settings = context.read<SettingsCubit>().state.settings;
    final index = days.indexWhere((d) => d.date.isSameDay(day));
    if (index != -1) {
      context.read<AgendaCubit>().updateDisplayedDate(
        wantedDate: index,
        fromMiniCalendar: false,
        settings: settings,
        fromHorizontalScroll: false,
      );
    }
  }

  Day? _findDay(List<Day> allDays, DateTime date) {
    for (final d in allDays) {
      if (d.date.isSameDay(date)) return d;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AgendaCubit, AgendaState>(
      listenWhen: (previous, current) =>
          current.status == AgendaStatus.dateUpdated &&
          previous.wantedDate != current.wantedDate,
      listener: (context, state) {
        if (state.days.isNotEmpty &&
            state.wantedDate >= 0 &&
            state.wantedDate < state.days.length) {
          final newDay = state.days[state.wantedDate].date.shrink(3);
          setState(() {
            _selectedDay = newDay;
            if (_currentMonth.year != newDay.year ||
                _currentMonth.month != newDay.month) {
              _currentMonth = DateTime(newDay.year, newDay.month);
            }
          });
        }
      },
      child: BlocBuilder<AgendaCubit, AgendaState>(
        builder: (context, state) {
          final allDays = state.days;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildMonthHeader(),
                _buildDayOfWeekLabels(),
                _buildCalendarGrid(allDays),
                if (_selectedDay != null) ...[
                  SizedBox(height: 1.h),
                  _buildSelectedDayEvents(allDays),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMonthHeader() {
    final locale = Localizations.localeOf(context).languageCode;
    final monthName = _currentMonth.toMonthName(locale);
    final year = _currentMonth.year.toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _previousMonth,
            icon: const Icon(Icons.chevron_left_rounded),
            iconSize: 28.sp,
          ),
          Text(
            '$monthName $year',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          IconButton(
            onPressed: _nextMonth,
            icon: const Icon(Icons.chevron_right_rounded),
            iconSize: 28.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildDayOfWeekLabels() {
    final locale = Localizations.localeOf(context).languageCode;
    final weekRef = _getWeekReference();
    final now = DateTime.now();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        children: List.generate(7, (index) {
          final weekday = (weekRef + index) % 7 + 1;
          final refDate = now.subtract(Duration(days: now.weekday - weekday));
          final disabled = _isDayDisabled(weekday);
          return Expanded(
            child: Center(
              child: Text(
                refDate.toWeekDayName(locale, short: true),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withValues(alpha: disabled ? 0.25 : 0.6),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCalendarGrid(List<Day> allDays) {
    final weekRef = _getWeekReference();
    final firstWeekday = weekRef + 1;
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    final startWeekday = firstDayOfMonth.weekday;
    final totalDays = lastDayOfMonth.day;
    final leadingEmpty = (startWeekday - firstWeekday + 7) % 7;
    final totalCells = leadingEmpty + totalDays;
    final rows = (totalCells / 7).ceil();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        children: List.generate(rows, (row) {
          return Row(
            children: List.generate(7, (col) {
              final cellIndex = row * 7 + col;
              if (cellIndex < leadingEmpty ||
                  cellIndex >= leadingEmpty + totalDays) {
                return Expanded(child: SizedBox(height: 7.h));
              }
              final dayNum = cellIndex - leadingEmpty + 1;
              final cellDate = DateTime(
                _currentMonth.year,
                _currentMonth.month,
                dayNum,
              );
              final day = _findDay(allDays, cellDate);
              final isToday = DateTime.now().isSameDay(cellDate);
              final isSelected =
                  _selectedDay != null && _selectedDay!.isSameDay(cellDate);
              final disabled = _isDayDisabled(cellDate.weekday);

              return Expanded(
                child: GestureDetector(
                  onTap: () => _selectDay(cellDate, allDays),
                  child: _buildDayCell(
                    dayNum: dayNum,
                    day: day,
                    isToday: isToday,
                    isSelected: isSelected,
                    isDisabled: disabled,
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget _buildDayCell({
    required int dayNum,
    Day? day,
    required bool isToday,
    required bool isSelected,
    required bool isDisabled,
  }) {
    final events = day?.events ?? [];
    final hasEvents = events.isNotEmpty;
    final alpha = isDisabled ? 0.3 : 1.0;

    return Container(
      height: 7.h,
      margin: EdgeInsets.all(0.3.w),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
            : isToday
                ? Theme.of(context).primaryColor.withValues(alpha: 0.08)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(0.8.w),
        border: isToday
            ? Border.all(color: Theme.of(context).primaryColor, width: 1.5)
            : isSelected
                ? Border.all(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.5),
                    width: 1,
                  )
                : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayNum.toString(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isToday || isSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: isToday
                  ? Theme.of(context).primaryColor
                  : Theme.of(
                      context,
                    ).textTheme.bodyLarge!.color!.withValues(alpha: alpha),
            ),
          ),
          if (hasEvents) ...[
            SizedBox(height: 0.2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: events.take(3).map((e) {
                return Container(
                  width: 1.2.w,
                  height: 1.2.w,
                  margin: EdgeInsets.symmetric(horizontal: 0.2.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(
                      alpha: isDisabled ? 0.3 : 1.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedDayEvents(List<Day> allDays) {
    final day = _findDay(allDays, _selectedDay!);
    final events = day?.events ?? [];
    final locale = Localizations.localeOf(context).languageCode;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedDay!.dateBeautifull(locale),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge!.color!.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 0.5.h),
          if (events.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                'No events',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color!.withValues(alpha: 0.4),
                ),
              ),
            )
          else
            ...events.map(
              (event) => SizedBox(
                height: 6.h,
                child: EventWidget(event: event),
              ),
            ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
