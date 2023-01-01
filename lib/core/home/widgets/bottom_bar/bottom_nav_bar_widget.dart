import 'package:flutter/material.dart';
import 'package:onyx/core/home/home_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';

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
    return InfiniteScrollLoopWidget(
      scrollController: scrollController,
      axisDirection: AxisDirection.right,
      builder: (context, index) {
        return GestureDetector(
          onTap: () => onTap(index),
          child: SizedBox(
            width: Res.bottomNavBarItemWidth,
            child: BottomNavBarComponentWidget(
              index: (index) % Res.screenCount,
              currentIndex: (currentIndex) % Res.screenCount,
            ),
          ),
        );
      },
    );
  }
}
