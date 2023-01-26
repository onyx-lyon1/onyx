import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';

class EventWidget extends StatelessWidget {
  final EventModel event;

  const EventWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          expand: false,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Theme.of(context).colorScheme.background,
          builder: (context) => EventDetailPage(event: event),
        );
      },
      child: Card(
        color: Theme.of(context).cardTheme.color,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 82,
                  height: 80,
                  padding: const EdgeInsets.only(left: 20),
                  color: Theme.of(context).cardTheme.color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${event.start.hour.toFixedLengthString(2)}:${event.start.minute.toFixedLengthString(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${event.end.hour.toFixedLengthString(2)}:${event.end.minute.toFixedLengthString(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.8),
                            fontSize: 11),
                      ),
                    ],
                  ),
                ),
                event.start.isBefore(DateTime.now()) &&
                        event.end.isAfter(DateTime.now())
                    ? Positioned(
                        left: -12,
                        top: 25,
                        child: Icon(
                          Icons.arrow_right_sharp,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(),
              ],
            ),
            Container(
              height: 50,
              width: 1,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width - 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${event.end.difference(event.start).dateBeautifull()} • ${event.location}',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
