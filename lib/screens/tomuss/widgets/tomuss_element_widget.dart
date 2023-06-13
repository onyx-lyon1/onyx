import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  color: color ?? Colors.transparent,
                  child: left,
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth * 0.02),
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.02),
                  child: right,
                ),
              ),
            ],
          );
        },
      ),
      // child: child,
    );
  }
}
