import 'package:flutter/material.dart';
import 'package:oloid2/core/extensions/int_to_sized_string.dart';
import 'package:oloid2/core/extensions/month_to_string.dart';
import 'package:oloid2/core/extensions/weekday_to_string.dart';
import 'package:oloid2/demo/map_demo.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:sizer/sizer.dart';

class EventDetailWidget extends StatelessWidget {
  final EventModel event;

  const EventDetailWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            event.description,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SelectableText(
                "${event.start.hour.toFixedLengthString(2)}h${event.start.minute.toFixedLengthString(2)}",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              SelectableText(
                "${event.end.hour.toFixedLengthString(2)}h${event.end.minute.toFixedLengthString(2)}",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SelectableText(
                '${event.start.toWeekDayName()} ${event.start.day} ${event.start.toMonthName()}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SelectableText(
                event.location,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h, width: 90.w, child: const MapDemoWidget()),
        ],
      ),
    );
  }
}
