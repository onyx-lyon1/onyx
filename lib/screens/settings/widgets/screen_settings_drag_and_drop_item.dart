import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/functionalities_to_human_export.dart';
import 'package:onyx/core/res.dart';

@override
DragAndDropItem screenSettingsDragAndDropItem(Functionalities functionality) {
  return DragAndDropItem(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        children: [
          Icon(functionality.toIcon()),
          Text(functionality.toCleanString())
        ],
      ),
    ),
  );
}
