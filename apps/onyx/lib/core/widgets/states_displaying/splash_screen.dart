import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<Offset>(
              tween: Tween<Offset>(
                begin: Offset(0, 10.w),
                end: Offset.zero,
              ),
              duration: Res.animationDuration,
              curve: Curves.easeInOut,
              builder: (context, offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: Opacity(
                    opacity: clampDouble(1 - offset.distance / 10.w, 0, 1),
                    child: SizedBox(
                      height: 40.w,
                      width: 40.w,
                      child: Image.asset(Res.iconPath),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30.sp,
              child: FutureBuilder(
                future: Future.delayed(Res.animationDuration),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SizedBox.shrink();
                  }
                  return TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: 1,
                    ),
                    duration: Res.animationDuration,
                    curve: Curves.easeInOut,
                    builder: (context, opacity, child) {
                      return Opacity(
                        opacity: opacity,
                        child: Text(
                          AppLocalizations.of(context).onyx,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
