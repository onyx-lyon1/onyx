import 'dart:async';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/functionalities_extension.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

DragAndDropItem screenSettingsDragAndDropItem(Functionalities functionality) {
  return DragAndDropItem(
    child: ScreenSettingsDragAndDropContent(functionality: functionality),
  );
}

class ScreenSettingsDragAndDropContent extends StatelessWidget {
  const ScreenSettingsDragAndDropContent(
      {super.key, required this.functionality});

  final Functionalities functionality;

  @override
  Widget build(BuildContext context) {
    final StreamController<bool> isExpandedController =
        StreamController<bool>(); //only used for the rotating arrow
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (bool b) => isExpandedController.add(b),
            initiallyExpanded: false,
            trailing: const SizedBox.shrink(),
            leading: StreamBuilder(
                stream: isExpandedController.stream,
                builder: (context, snap) {
                  return AnimatedRotation(
                      turns: (snap.data ?? false) ? .5 : 0,
                      duration: Res.animationDuration,
                      child: const Icon(Icons
                          .keyboard_arrow_down_outlined) // your svgImage here
                      );
                }),
            title: SizedBox(
              // height: 50,
              child: Row(
                children: [
                  Icon(functionality.toIcon()),
                  Text(
                      functionality.toCleanString(AppLocalizations.of(context)))
                ],
              ),
            ),
            childrenPadding: const EdgeInsets.all(15),
            expandedCrossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocListener<SettingsCubit, SettingsState>(
                //bloc listener handling the collapsing when draging an item
                listenWhen: (previous, current) {
                  if (previous is! SettingsReady || current is! SettingsReady) {
                    return false;
                  }
                  return current.collapseAll;
                },
                listener: (context, state) {
                  if (state is! SettingsReady) return;
                  if (state.collapseAll) {
                    if (ExpansibleController.maybeOf(context)?.isExpanded ??
                        false) {
                      ExpansibleController.maybeOf(context)?.collapse();
                    }
                  }
                },
                child: functionality.toSettings(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
