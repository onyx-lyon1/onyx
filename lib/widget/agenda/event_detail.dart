import 'package:flutter/material.dart';
import 'package:oloid2/model/event_model.dart';
import 'package:oloid2/others/int_to_sized_string.dart';
import 'package:sizer/sizer.dart';

class EventDetail extends StatelessWidget {
  final EventModel event;

  const EventDetail({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 3,
            width: 12.w,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.description),
                    Text(event.description),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Text(event.location),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    Text(
                        '${event.start.hour.toFixedLengthString(2)}:${event.start.minute.toFixedLengthString(2)} --> ${event.end.hour.toFixedLengthString(2)}:${event.end.minute.toFixedLengthString(2)}'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    Text(event.eventLastModified.toString()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
