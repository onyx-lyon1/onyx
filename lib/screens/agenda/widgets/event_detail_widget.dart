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
    return Column(
      children: [
        Container(
          color: Theme.of(context).cardColor,
          width: 100.w,
          height: 7.h,
          child: Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_upward_rounded)),
              Text(
                "Détail de l'évènement",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.sp,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                event.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    SelectableText(
                      "${event.start.hour.toFixedLengthString(2)}h${event.start.minute.toFixedLengthString(2)}",
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                    SelectableText(
                      "${event.end.hour.toFixedLengthString(2)}h${event.end.minute.toFixedLengthString(2)}",
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    SelectableText(
                      '${event.start.toWeekDayName()} ${event.start.day} ${event.start.toMonthName()}',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    SelectableText(
                      event.location,
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 40.h,
                    width: 90.w,
                    child: const MapDemoWidget(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        print("Tapped");
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Text(
                          "Itinéraire",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
