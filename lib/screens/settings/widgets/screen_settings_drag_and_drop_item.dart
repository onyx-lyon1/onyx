import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/functionalities_to_human_export.dart';
import 'package:onyx/core/res.dart';
import 'package:sizer/sizer.dart';

@override
DragAndDropItem screenSettingsDragAndDropItem(Functionalities functionality) {
  return DragAndDropItem(
    child: ScreenSettingsDragAndDropContent(functionality: functionality),
  );
}

class ScreenSettingsDragAndDropContent extends StatefulWidget {
  const ScreenSettingsDragAndDropContent(
      {Key? key, required this.functionality})
      : super(key: key);

  final Functionalities functionality;

  @override
  State<ScreenSettingsDragAndDropContent> createState() =>
      _ScreenSettingsDragAndDropContentState();
}

class _ScreenSettingsDragAndDropContentState
    extends State<ScreenSettingsDragAndDropContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },
          trailing: const SizedBox(height: 0, width: 0),
          leading: AnimatedRotation(
              turns: _isExpanded ? .5 : 0,
              duration: Res.animationDuration,
              child: const Icon(
                  Icons.keyboard_arrow_down_outlined) // your svgImage here
              ),
          title: Row(
            children: [
              Icon(widget.functionality.toIcon()),
              Text(widget.functionality.toCleanString())
            ],
          ),
          childrenPadding: const EdgeInsets.all(15),
          expandedCrossAxisAlignment: CrossAxisAlignment.center,
          children: [widget.functionality.toSettings()],
        ),
      ),
    );
  }
}
