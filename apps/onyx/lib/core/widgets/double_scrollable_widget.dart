import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// don't forget to add NeverScrollableScrollPhysics() to all the scrollable widgets
class MultiScrollableWidget extends StatefulWidget {
  const MultiScrollableWidget(
      {super.key,
      required this.pageController,
      required this.listScrollController,
      required this.child});

  final List<ScrollController> listScrollController;
  final PageController pageController;
  final Widget child;

  @override
  State<MultiScrollableWidget> createState() => _MultiScrollableWidgetState();
}

class _MultiScrollableWidgetState extends State<MultiScrollableWidget> {
  late ScrollController _activeScrollController;
  Drag? _drag;

  bool? forward;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    for (var scrollController in widget.listScrollController) {
      scrollController.dispose();
    }
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
    );
  }

  void _handleDragStart(DragStartDetails details) {
    int i = _getScrollControllerIndex();
    if (widget.listScrollController[i].hasClients) {
      final RenderBox renderBox = widget
          .listScrollController[i].position.context.storageContext
          .findRenderObject() as RenderBox;
      if (renderBox.paintBounds
          .shift(renderBox.localToGlobal(Offset.zero))
          .contains(details.globalPosition)) {
        _activeScrollController = widget.listScrollController[i];
        _drag = _activeScrollController.position.drag(details, _disposeDrag);
        return;
      }
    }
    _activeScrollController = widget.pageController;
    _drag = widget.pageController.position.drag(details, _disposeDrag);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    int i = _getScrollControllerIndex();
    if (widget.listScrollController[i] == _activeScrollController &&
        ((details.primaryDelta! > 0 &&
                _activeScrollController.position.extentBefore == 0) ||
            (details.primaryDelta! < 0 &&
                _activeScrollController.position.extentAfter == 0))) {
      forward = details.primaryDelta! > 0;
      _activeScrollController = widget.pageController;
      _drag?.cancel();
      _drag = widget.pageController.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    if (_activeScrollController == widget.pageController &&
        ((forward != null) && details.primaryDelta! > 0 != forward!)) {
      if ((_activeScrollController.position.pixels %
                  _activeScrollController.position.viewportDimension)
              .abs() <
          15) {
        i = _getScrollControllerIndex();
        if (widget.listScrollController[i].hasClients) {
          _activeScrollController = widget.listScrollController[i];
          _drag?.cancel();
          _drag = widget.listScrollController[i].position.drag(
              DragStartDetails(
                  globalPosition: details.globalPosition,
                  localPosition: details.localPosition),
              _disposeDrag);
        }
      }
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

  int _getScrollControllerIndex() {
    //a fonction got get the current screen in use by the pageview
    if (widget.listScrollController.length == 1) {
      return 0;
    }
    return widget.pageController.page!.toInt();
  }
}
