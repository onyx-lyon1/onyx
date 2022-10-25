import 'package:flutter/material.dart';
import 'package:oloid2/model/event_model.dart';
import 'package:oloid2/others/date_beautifull.dart';
import 'package:oloid2/others/int_to_sized_string.dart';

class Event extends StatelessWidget {
  final EventModel event;
  final Function(EventModel event) onTap;

  const Event({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(event),
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
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${event.end.hour}:${event.end.minute}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
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
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${event.location} • ${event.end.difference(event.start).dateBeautifull()}',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
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
