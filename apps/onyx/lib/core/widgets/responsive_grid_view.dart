import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResponsiveGridView extends StatelessWidget {
  const ResponsiveGridView({
    Key? key,
    this.physics,
    this.padding,
    required this.maxCrossAxisExtent,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.shrinkWrap = false,
    required this.children,
  }) : super(key: key);
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final double maxCrossAxisExtent;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final bool shrinkWrap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if ((Device.width / maxCrossAxisExtent).round() <= 1) {
      return ListView(
        physics: physics,
        padding: padding,
        shrinkWrap: shrinkWrap,
        children: children
            .map((e) => Padding(
                padding: EdgeInsets.symmetric(
                  vertical: mainAxisSpacing,
                ),
                child: e))
            .toList(),
      );
    } else {
      return GridView.builder(
        physics: physics,
        padding: padding,
        shrinkWrap: shrinkWrap,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (Device.width / maxCrossAxisExtent).round(),
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      );
    }
  }
}
