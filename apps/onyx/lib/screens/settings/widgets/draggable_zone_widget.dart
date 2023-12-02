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
              header: Padding(
                padding: EdgeInsets.only(
                  top: 2.h,
                  left: 4.w,
                  bottom: 0.8.h,
                ),
                child: const Text(
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
              header: Padding(
                padding: EdgeInsets.only(
                  top: 2.h,
                  left: 4.w,
                  bottom: 0.8.h,
                ),
                child: const Text(
                  'Désactivé',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              children: context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .disabledFunctionalities
                  .map((e) => screenSettingsDragAndDropItem(e))
                  .toList())
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
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
