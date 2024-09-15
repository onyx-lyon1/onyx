import 'dart:io';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DraggableZoneWidget extends StatelessWidget {
  const DraggableZoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) {
        return !current.collapseAll;
      },
      builder: (context, state) {
        List<DragAndDropList> contents = [
          DragAndDropList(
              canDrag: false,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              contentsWhenEmpty: const SizedBox.shrink(),
              header: Padding(
                padding: EdgeInsets.only(
                  top: 2.h,
                  left: 4.w,
                  bottom: 0.8.h,
                ),
                child: Text(
                  AppLocalizations.of(context).enabled,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              horizontalAlignment: MainAxisAlignment.center,
              children: [
                for (var i in context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .enabledFunctionalities)
                  if (!(Platform.isIOS && i == Functionalities.izly))
                    screenSettingsDragAndDropItem(i)
              ]),
          DragAndDropList(
              canDrag: false,
              contentsWhenEmpty: const SizedBox.shrink(),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              header: Padding(
                padding: EdgeInsets.only(
                  top: 2.h,
                  left: 4.w,
                  bottom: 0.8.h,
                ),
                child: Text(
                  AppLocalizations.of(context).disabled,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              children: [
                for (var i in context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .disabledFunctionalities)
                  if (!(Platform.isIOS && i == Functionalities.izly))
                    screenSettingsDragAndDropItem(i)
              ]),
        ];
        return DragAndDropLists(
          listPadding: EdgeInsets.symmetric(horizontal: 4.w),
          disableScrolling: true,
          itemDivider: const Divider(
            height: 4,
            color: Colors.transparent,
          ),
          listDividerOnLastChild: false,
          listDivider: Divider(
            height: 3.h,
            color: Colors.transparent,
          ),
          lastListTargetSize: 0.0,
          itemDragHandle: DragHandle(
            verticalAlignment: DragHandleVerticalAlignment.top,
            onLeft:
                context.read<SettingsCubit>().state.settings.language == 'ar'
                    ? true
                    : false,
            child: Container(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
                // 50 is the height of the item
                // 30 is the size of the icon
                // so just centering vertically the icon
                top: (50 / 2 - 30 / 2),
              ),
              child: Icon(
                Icons.drag_indicator_rounded,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          itemSizeAnimationDurationMilliseconds:
              Res.animationDuration.inMilliseconds,
          listSizeAnimationDurationMilliseconds:
              Res.animationDuration.inMilliseconds,
          children: contents,
          onItemDraggingChanged: (DragAndDropItem item, bool isDragging) {
            if (isDragging) {
              context.read<SettingsCubit>().collapseAll();
            }
          },
          onItemReorder: (int oldItemIndex, int oldListIndex, int newItemIndex,
              int newListIndex) {
            context.read<SettingsCubit>().move(
                oldEnabled: oldListIndex == 0,
                newEnabled: newListIndex == 0,
                oldIndex: oldItemIndex,
                newIndex: newItemIndex);
          },
          onListReorder: (_, __) {},
        );
      },
    );
  }
}
