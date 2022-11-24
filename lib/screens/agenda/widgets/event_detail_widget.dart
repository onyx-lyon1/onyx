import 'package:flutter/material.dart';
import 'package:oloid2/core/extensions/extensions_export.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:sizer/sizer.dart';

class EventDetailWidget extends StatelessWidget {
  final EventModel event;

  const EventDetailWidget({Key? key, required this.event}) : super(key: key);

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
            child: SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.description),
                      Expanded(
                        child: Text(
                          event.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Expanded(
                          child: Text(event.location,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      Expanded(
                        child: Text(
                            '${event.start.hour.toFixedLengthString(2)}:${event.start.minute.toFixedLengthString(2)} --> ${event.end.hour.toFixedLengthString(2)}:${event.end.minute.toFixedLengthString(2)}',
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.hourglass_bottom),
                      Expanded(
                          child: Text(
                              event.end
                                  .difference(event.start)
                                  .dateBeautifull(),
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.drive_file_rename_outline),
                      Expanded(
                          child: Text(event.teacher,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
