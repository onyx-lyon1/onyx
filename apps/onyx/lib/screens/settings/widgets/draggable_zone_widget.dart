import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              header: const Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  left: 15,
                  right: 15,
                  bottom: 5,
                ),
                child: Text(
                  'Activé',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              horizontalAlignment: MainAxisAlignment.center,
              children: context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .enabledFunctionalities
                  .map((e) => screenSettingsDragAndDropItem(e))
                  .toList()),
          DragAndDropList(
              canDrag: false,
              contentsWhenEmpty: const SizedBox.shrink(),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              header: const Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  left: 15,
                  right: 15,
                  bottom: 5,
                ),
                child: Text(
                  'Désactivé',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              horizontalAlignment: MainAxisAlignment.center,
              children: context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .disabledFunctionalities
                  .map((e) => screenSettingsDragAndDropItem(e))
                  .toList())
        ];
        return DragAndDropLists(
          listPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          disableScrolling: true,
          itemDivider: const Divider(
            thickness: 2,
            height: 2,
            color: Colors.transparent,
          ),
          itemDragHandle: DragHandle(
            verticalAlignment: DragHandleVerticalAlignment.top,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: ((!Res.isWide) ? 7.h : 7.h) - 5.h),
              child: Icon(
                Icons.drag_indicator_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          itemSizeAnimationDurationMilliseconds: Res.animationDuration.inMilliseconds,
          listSizeAnimationDurationMilliseconds: Res.animationDuration.inMilliseconds,
          children: contents,
          lastListTargetSize: 0.0,
          onItemDraggingChanged: (DragAndDropItem item, bool isDragging) {
            if (isDragging) {
              context.read<SettingsCubit>().collapseAll();
            }
          },
          onItemReorder: (int oldItemIndex, int oldListIndex,
              int newItemIndex, int newListIndex) {
            context.read<SettingsCubit>().move(
                oldEnabled: oldListIndex == 0,
                newEnabled: newListIndex == 0,
                oldIndex: oldItemIndex,
                newIndex: newItemIndex);
          },
          onListReorder: (int oldListIndex, int newListIndex) {},
        );
      },
    );
  }
}
