import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final bool compact;

  const EventWidget({
    Key? key,
    required this.event,
    this.compact = false,
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
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Row(
          children: [
            (!compact)
                ? Flexible(
                    flex: 40,
                    fit: FlexFit.tight,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '${event.start.hour.toFixedLengthString(2)}:${event.start.minute.toFixedLengthString(2)}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: 16,
                                ),
                              ),
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
                        (event.start.isBefore(DateTime.now()) &&
                                event.end.isAfter(DateTime.now()))
                            ? Transform.translate(
                                offset: Offset(-(30.sp * 0.45), 0),
                                child: Icon(
                                  Icons.arrow_right_rounded,
                                  size: 30.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            (!compact)
                ? Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 9.h,
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                    ),
                  )
                : const SizedBox.shrink(),
            Flexible(
              flex: 150,
              child: Container(
                padding: EdgeInsets.only(left: (!compact) ? 4.w : 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!compact)
                      Text(
                        event.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    else
                      Flexible(
                        child: AutoSizeText(
                          event.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color!,
                            fontWeight: FontWeight.w500,
                          ),
                          minFontSize: 9,
                        ),
                      ),
                    if (!compact)
                      AutoSizeText(
                        (!compact)
                            ? '${event.end.difference(event.start).durationBeautifull()} • ${event.location}'
                            : event.location,
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
            ),
          ],
        ),
      ),
    );
  }
}
