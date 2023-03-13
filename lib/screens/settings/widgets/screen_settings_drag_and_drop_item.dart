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
  GlobalKey key = GlobalKey();
  late double childHeight;

  @override
  void initState() {
    childHeight = 9.h;
    super.initState();
  }

  Future<void> updateChildHeight() async {
    if (_isExpanded) {
      int i = 0;
      while (key.currentContext?.size?.height == null && i < 10) {
        i++;
        await Future.delayed(const Duration(milliseconds: 100), () {});
      }
    }
    setState(() {
      if (_isExpanded) {
        // set the height to the height of the child for the animation
        childHeight = (key.currentContext?.size?.height ?? 0.0) + 15.h;
      } else {
        childHeight = 9.h;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
      ),
      child: AnimatedContainer(
        duration: Res.animationDuration,
        height: childHeight,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: ExpansionTile(
              onExpansionChanged: (value) async {
                // This is a hack to wait for the widget to be built
                _isExpanded = value;
                await updateChildHeight();
                setState(() {});
              },
              maintainState: true,
              trailing: const SizedBox.shrink(),
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
              children: [
                widget.functionality
                    .toSettings(key: key, sizeUpdate: updateChildHeight)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
