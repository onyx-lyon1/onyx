import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:sizer/sizer.dart';

class TomussCompactElementWidget extends StatelessWidget {
  const TomussCompactElementWidget({
    super.key,
    this.color,
    this.onTap,
    this.child,
    this.text1,
    this.text2,
    this.text3,
  });

  final Color? color;
  final Function()? onTap;
  final Widget? child;
  final String? text1;
  final String? text2;
  final String? text3;

  @override
  Widget build(BuildContext context) {
    assert(
        (text1 != null && text2 != null && text3 != null) || (child != null));
    return SizedBox(
      height: 11.h,
      width: 20.w,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: color ?? Theme.of(context).colorScheme.background,
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: onTap,
            child: (child != null)
                ? child
                : Column(
                    children: [
                      Text(
                        text1!,
                        style: TextStyle(
                          color: OnyxTheme.darkTheme().colorScheme.background,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: Res.bottomNavBarItemWidth,
                        height: Res.bottomNavBarHeight / 4,
                        child: AutoSizeText(
                          text2!,
                          maxLines: 1,
                          minFontSize: 7,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.clip,
                            color: OnyxTheme.darkTheme().colorScheme.background,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Res.bottomNavBarItemWidth,
                        height: Res.bottomNavBarHeight / 4,
                        child: AutoSizeText(
                          text3!,
                          maxLines: 1,
                          minFontSize: 8,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                            color: OnyxTheme.darkTheme().colorScheme.background,
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}
