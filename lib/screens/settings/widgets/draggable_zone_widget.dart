import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:sizer/sizer.dart';

class DraggableZoneWidget extends StatelessWidget {
  const DraggableZoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
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
          listPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          disableScrolling: true,
          itemDivider: const Divider(
            thickness: 2,
            height: 2,
            color: Colors.transparent,
          ),
          itemDragHandle: DragHandle(
            verticalAlignment: DragHandleVerticalAlignment.top,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.9.h),
              child: Icon(
                Icons.drag_indicator_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          itemSizeAnimationDurationMilliseconds: 200,
          listSizeAnimationDurationMilliseconds: 200,
          children: contents,
          lastListTargetSize: 0.0,
          onItemReorder: (int oldItemIndex, int oldListIndex, int newItemIndex,
              int newListIndex) {
            if ((oldListIndex == 0 && newListIndex == 1) &&
                context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .enabledFunctionalities[oldItemIndex] !=
                    Functionalities.settings) {
              Functionalities item = context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .enabledFunctionalities[oldItemIndex];

              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(
                          enabledFunctionalities: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .enabledFunctionalities
                              .where((element) => element != item)
                              .toList(),
                          disabledFunctionalities: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .disabledFunctionalities
                              .toList()
                            ..insert(newItemIndex, item)));
            } else if (oldListIndex == 1 && newListIndex == 0) {
              Functionalities item = context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .disabledFunctionalities[oldItemIndex];
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(
                          disabledFunctionalities: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .disabledFunctionalities
                              .where((element) => element != item)
                              .toList(),
                          enabledFunctionalities: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .enabledFunctionalities
                              .toList()
                            ..insert(newItemIndex, item)));
            } else if (oldListIndex == 0 && newListIndex == 0) {
              Functionalities item = context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .enabledFunctionalities[oldItemIndex];
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(
                          enabledFunctionalities: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .enabledFunctionalities
                              .toList()
                            ..removeAt(oldItemIndex)
                            ..insert(newItemIndex, item)));
            } else if ((oldListIndex == 1 && newListIndex == 1) &&
                context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .enabledFunctionalities[oldItemIndex] !=
                    Functionalities.settings) {
              Functionalities item = context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .disabledFunctionalities[oldItemIndex];
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(
                          disabledFunctionalities: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .disabledFunctionalities
                              .toList()
                            ..removeAt(oldItemIndex)
                            ..insert(newItemIndex, item)));
            }
          },
          onListReorder: (int oldListIndex, int newListIndex) {},
        );
      },
    );
  }
}
