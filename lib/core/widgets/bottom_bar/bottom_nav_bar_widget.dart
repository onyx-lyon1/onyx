import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oloid2/core/res.dart';
import 'package:oloid2/core/widgets/core_widget_export.dart';

class BottomNavBarWidget extends StatelessWidget {
  final Function(int index) onTap;
  final int currentIndex;
  final ScrollController scrollController;

  const BottomNavBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Key forwardListKey = const Key("list");
    Widget forwardList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return GestureDetector(
            onTap: () => onTap(index + 1),
            child: SizedBox(
              width: Res.bottomNavBarItemWidth,
              child: BottomNavBarComponentWidget(
                index: (index + 1) % Res.screenCount,
                currentIndex: (currentIndex) % Res.screenCount,
              ),
            ));
      }),
      key: forwardListKey,
    );

    Widget reverseList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return GestureDetector(
          onTap: () => onTap(-index),
          child: SizedBox(
            width: Res.bottomNavBarItemWidth,
            child: BottomNavBarComponentWidget(
              index: -(index) % Res.screenCount,
              currentIndex: (currentIndex) % Res.screenCount,
            ),
          ),
        );
      }),
    );
    return Scrollable(
      axisDirection: AxisDirection.right,
      controller: scrollController,
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return Viewport(
          axisDirection: AxisDirection.right,
          offset: offset,
          center: forwardListKey,
          slivers: [
            reverseList,
            forwardList,
          ],
        );
      },
    );
  }
}
