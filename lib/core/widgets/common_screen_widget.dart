import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:sizer/sizer.dart';

class CommonScreenWidget extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? state;
  final Future<void> Function()? onRefresh;

  const CommonScreenWidget(
      {Key? key, this.header, required this.body, this.state, this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (state != null) ? state! : Container(),
        AnimatedContainer(
          duration: Res.animationDuration,
          margin: EdgeInsets.only(top: (state != null) ? 5.h : 0),
          width: 100.w,
          color: Theme.of(context).backgroundColor,
          child: (onRefresh != null)
              ? RefreshIndicator(
                  onRefresh: onRefresh!,
                  backgroundColor: Theme.of(context).backgroundColor,
                  color: Theme.of(context).primaryColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: AnimatedContainer(
                      duration: Res.animationDuration,
                      width: 100.w,
                      height: 100.h - (10.h - ((state != null) ? 5.h : 0)),
                      child: Column(
                        children: [
                          if (header != null)
                            Container(
                              width: 100.w,
                              height: Res.bottomNavBarHeight,
                              color: Theme.of(context).cardColor,
                              child: header,
                            ),
                          Expanded(
                            child: body,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    if (header != null)
                      Container(
                        width: 100.w,
                        height: Res.bottomNavBarHeight,
                        color: Theme.of(context).cardColor,
                        child: header,
                      ),
                    Expanded(
                      child: body,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
