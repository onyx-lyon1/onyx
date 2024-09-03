import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TomussCompactElementWidget extends StatelessWidget {
  const TomussCompactElementWidget({
    super.key,
    this.color,
    this.onTap,
    this.child1,
    this.child2,
    this.child3,
    this.text1,
    this.text2,
    this.text3,
  });

  final Color? color;
  final Function()? onTap;
  final Widget? child1;
  final Widget? child2;
  final Widget? child3;
  final String? text1;
  final String? text2;
  final String? text3;

  @override
  Widget build(BuildContext context) {
    assert(
        (text1 != null && child1 == null) || (text1 == null && child1 != null));
    assert(
        (text2 != null && child2 == null) || (text2 == null && child2 != null));
    assert(
        (text3 != null && child3 == null) || (text3 == null && child3 != null));
    return SizedBox(
      width: (!Res.isWide)
          ? Res.bottomNavBarHeight * 1.3
          : Res.bottomNavBarHeight * 3,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: color ?? Theme.of(context).colorScheme.surface,
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(
                  (Device.orientation == Orientation.portrait) ? 1.w : 1.h),
              child: Column(
                children: [
                  Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: (child1 != null)
                          ? child1!
                          : AutoSizeText(
                              text1!,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.clip,
                                color: (Theme.of(context).colorScheme.surface ==
                                        OnyxTheme.darkTheme.colorScheme.surface)
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color
                                    : OnyxTheme.darkTheme.colorScheme.surface,
                              ),
                            ),
                    ),
                  ),
                  Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: Center(
                      child: (child2 != null)
                          ? child2!
                          : Center(
                              child: AutoSizeText(
                                text2!,
                                maxLines: 1,
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.clip,
                                  color: (Theme.of(context)
                                              .colorScheme
                                              .surface ==
                                          OnyxTheme
                                              .darkTheme.colorScheme.surface)
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color
                                      : OnyxTheme.darkTheme.colorScheme.surface,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: (child3 != null)
                          ? child3!
                          : AutoSizeText(
                              text3!,
                              maxLines: 2,
                              minFontSize: 8.sp.roundToDouble(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                overflow: TextOverflow.clip,
                                color: (Theme.of(context).colorScheme.surface ==
                                        OnyxTheme.darkTheme.colorScheme.surface)
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color
                                    : OnyxTheme.darkTheme.colorScheme.surface,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
