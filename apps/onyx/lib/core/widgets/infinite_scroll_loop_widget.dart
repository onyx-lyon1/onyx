import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InfiniteScrollLoopWidget extends StatelessWidget {
  final ScrollController scrollController;
  final AxisDirection axisDirection;
  final ScrollPhysics physics;
  final Widget? Function(BuildContext context, int index) builder;
  final void Function(double)? onChange;

  const InfiniteScrollLoopWidget({
    Key? key,
    required this.scrollController,
    required this.axisDirection,
    required this.builder,
    this.onChange,
    this.physics = const ScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Key forwardListKey = const Key("list");
    Widget forwardList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return builder(context, index);
        // return children[index % children.length];
      }),
      key: forwardListKey,
    );

    Widget reverseList = SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return builder(context, -(index + 1));
          // return children[(-(index + 1) % children.length)];
        },
      ),
    );
    if (onChange != null) {
      scrollController.addListener(() {
        if (scrollController.hasClients) {
          onChange!(scrollController.offset);
        }
      });
    }
    return Scrollable(
      axisDirection: axisDirection,
      controller: scrollController,
      physics: physics,
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return Viewport(
          axisDirection: axisDirection,
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
