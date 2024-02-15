import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final bool compact;

  const EventWidget({
    super.key,
    required this.event,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      //Theme.of(context).cardTheme.color!,
      closedElevation: 0.0,
      openElevation: 0.0,
      openColor: Theme.of(context).colorScheme.background,
      middleColor: Theme.of(context).colorScheme.background,
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      openBuilder: (context, _) => EventDetailPage(
          event: event,
          locale: Locale(AppLocalizations.of(context).localeName)),
      closedBuilder: (context, _) {
        return Card(
          color: Theme.of(context).cardTheme.color,
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(0.8.w),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      event.name,
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        fontWeight: FontWeight.w500,
                      ),
                      minFontSize: 10,
                    ),
                  ),
                  if (!compact)
                    AutoSizeText(
                      (!compact)
                          ? AppLocalizations.of(context).eventSubtitle(
                              event.end
                                  .difference(event.start)
                                  .durationBeautifull(),
                              event.location)
                          : event.location,
                      textAlign: TextAlign.center,
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
        );
      },
    );
  }
}
