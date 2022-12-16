import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InfiniteScrollWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List<Widget> children;
  final AxisDirection axisDirection;

  const InfiniteScrollWidget({
    Key? key,
    required this.scrollController,
    required this.children,
    required this.axisDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Key forwardListKey = const Key("list");
    Widget forwardList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return children[index % children.length];
      }),
      key: forwardListKey,
    );

    Widget reverseList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return children[(-(index + 1) % children.length)];
      }),
    );
    return Scrollable(
      axisDirection: axisDirection,
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
