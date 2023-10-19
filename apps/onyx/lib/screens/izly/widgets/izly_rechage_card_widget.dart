import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlayRechargeCardWidget extends StatelessWidget {
  const IzlayRechargeCardWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.child,
      required this.pageController});
  final IconData icon;
  final String text;
  final Widget child;
  final PageController pageController;

  // pageController.animateToPage(0,
  // duration: Res.animationDuration,
  // curve: Curves.easeInOut))
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      closedColor: Theme.of(context).primaryColor,
      openColor: Theme.of(context).colorScheme.background,
      transitionDuration: Res.animationDuration,
      onClosed: (value) {
        Future.delayed(Res.animationDuration, () {
          pageController.animateToPage(0,
              duration: Res.animationDuration, curve: Curves.easeInOut);
        });
      },
      openBuilder: (context, closeContainer) => child,
      closedBuilder: (context, openContainer) => InkWell(
        onTap: openContainer,
        child: SizedBox(
          width: 30.w,
          height: 30.w,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
