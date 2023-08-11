import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TomussElementWidget extends StatelessWidget {
  const TomussElementWidget({
    super.key,
    this.color,
    this.onTap,
    required this.left,
    required this.right,
  });

  final Color? color;
  final Function()? onTap;
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 11.h,
      // (Device.screenType == ScreenType.mobile &&
      //         Device.orientation == Orientation.portrait)
      //     ? 11.h
      //     : null,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    color: color ?? Theme.of(context).primaryColor,
                    height: constraints.maxHeight,
                    child: left,
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: EdgeInsets.only(left: constraints.maxWidth * 0.02),
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.02),
                    child: right,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // child: child,
    );
  }
}
