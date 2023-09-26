import 'package:flutter/material.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SizedEventWidget extends StatelessWidget {
  const SizedEventWidget({
    super.key,
    required this.heightFactor,
    required this.numberPerColumn,
    required this.event,
    required this.columnWidth,
  });

  final double heightFactor;
  final int numberPerColumn;
  final Event event;
  final double columnWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ((Res.agendaDayDuration.inHours / heightFactor).h + 0.25.h) *
          ((event.end.difference(event.start)).inMinutes / 60),
      width: columnWidth / numberPerColumn,
      child: EventWidget(
        event: event,
        compact: true,
      ),
    );
  }
}
