import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TomussCompactElementWidget extends StatelessWidget {
  const TomussCompactElementWidget({
    super.key,
    this.color,
    this.onTap,
    required this.child,
  });

  final Color? color;
  final Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 11.h,
      width: 20.w,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: color ?? Theme.of(context).colorScheme.background,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
