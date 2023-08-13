import 'dart:math';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/functionalities_to_human_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
  final double _baseHeight = (!Res.isWide) ? 8.h : 7.h;
  bool _isExpanded = false;
  GlobalKey key = GlobalKey();
  late double childHeight;
  late int _key;

  @override
  void initState() {
    childHeight = _baseHeight;
    _collapse();
    super.initState();
  }

  _collapse() {
    int newKey = 0;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
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
        childHeight = (key.currentContext?.size?.height ?? 0.0) +
            ((!Res.isWide) ? 13.h : 13.h);
      } else {
        childHeight = _baseHeight;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.collapseAll) {
          _isExpanded = false;
          _collapse();
          updateChildHeight();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background,
        ),
        child: AnimatedContainer(
          duration: Res.animationDuration,
          height: childHeight,
          alignment: Alignment.topCenter,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              key: Key(_key.toString()),
              onExpansionChanged: (value) async {
                // This is a hack to wait for the widget to be built
                _isExpanded = value;
                await updateChildHeight();
                setState(() {});
              },
              initiallyExpanded: false,
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
