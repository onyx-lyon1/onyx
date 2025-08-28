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
            SizedBox(
              height: 40.w,
              width: 40.w,
              child: Image.asset(Res.iconPath),
            ),
            TweenAnimationBuilder<double>(
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
            ),
          ],
        ),
      ),
    );
  }
}
