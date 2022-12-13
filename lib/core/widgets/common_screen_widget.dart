import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonScreenWidget extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? state;
  final Future<void> Function() onRefresh;

  const CommonScreenWidget(
      {Key? key,
      this.header,
      required this.body,
      this.state,
      required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (state != null) ? state! : Container(),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(top: (state != null) ? 5.h : 0),
          height: (state != null) ? 85.h : 90.h,
          width: 100.w,
          color: Theme.of(context).backgroundColor,
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).backgroundColor,
            color: Theme.of(context).primaryColor,
            onRefresh: onRefresh,
            child: Column(
              children: [
                if (header != null)
                  Container(
                      width: 100.w,
                      height: 10.h,
                      color: Theme.of(context).cardColor,
                      child: header),
                Expanded(
                  child: body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
