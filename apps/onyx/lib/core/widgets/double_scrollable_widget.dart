import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// don't forget to add NeverScrollableScrollPhysics() to all the scrollable widgets
class DoubleScrollableWidget extends StatefulWidget {
  const DoubleScrollableWidget(
      {super.key,
      required this.pageController,
      required this.listScrollController,
      required this.child});

  final ScrollController listScrollController;
  final PageController pageController;
  final Widget child;

  @override
  State<DoubleScrollableWidget> createState() => _DoubleScrollableWidgetState();
}

class _DoubleScrollableWidgetState extends State<DoubleScrollableWidget> {
  late ScrollController _activeScrollController;
  Drag? _drag;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    widget.listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        VerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
                (VerticalDragGestureRecognizer instance) {
          instance
            ..onStart = _handleDragStart
            ..onUpdate = _handleDragUpdate
            ..onEnd = _handleDragEnd
            ..onCancel = _handleDragCancel;
        })
      },
      behavior: HitTestBehavior.opaque,
      child: widget.child,
      //   PageView(
      // controller: widget.pageController,
      // scrollDirection: Axis.vertical,
      // physics: const NeverScrollableScrollPhysics(),
      // children: [
      //   Center(child: Text('Page 1')),
      //   ListView(
      //       controller: widget.listScrollController,
      //       physics: const NeverScrollableScrollPhysics(),
      //       children: List.generate(20, (int index) {
      //         return ListTile(title: Text('Item $index'));
      //       })),
      //   Center(child: Text('Page 1')),
      // ],
      // ),
    );
  }

  void _handleDragStart(DragStartDetails details) {
    if (widget.listScrollController.hasClients) {
      final RenderBox renderBox = widget
          .listScrollController.position.context.storageContext
          .findRenderObject() as RenderBox;
      if (renderBox.paintBounds
          .shift(renderBox.localToGlobal(Offset.zero))
          .contains(details.globalPosition)) {
        _activeScrollController = widget.listScrollController;
        _drag = _activeScrollController.position.drag(details, _disposeDrag);
        return;
      }
    }
    _activeScrollController = widget.pageController;
    _drag = widget.pageController.position.drag(details, _disposeDrag);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_activeScrollController == widget.listScrollController &&
        ((details.primaryDelta! > 0 &&
                _activeScrollController.position.extentBefore == 0) ||
            (details.primaryDelta! < 0 &&
                _activeScrollController.position.extentAfter == 0))) {
      _activeScrollController = widget.pageController;
      _drag?.cancel();
      _drag = widget.pageController.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    _drag?.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_drag != null) {
      _drag?.end(details);
    }
  }

  void _handleDragCancel() {
    if (_drag != null) {
      _drag?.cancel();
    }
  }

  void _disposeDrag() {
    _drag = null;
  }
}
