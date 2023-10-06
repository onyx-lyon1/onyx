import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyRechargePage extends StatelessWidget {
  const IzlyRechargePage({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          child: IconButton(
            onPressed: () => pageController.animateToPage(0,
                duration: Res.animationDuration, curve: Curves.easeInOut),
            icon: Icon(Icons.keyboard_double_arrow_up_rounded,
                size: 40.sp,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IzlayRechargeCardWidget(
                  icon: Icons.compare_arrows_rounded,
                  text: "Virement",
                  pageController: pageController,
                  child: const IzlyRechargeTranferPage(),
                ),
                SizedBox(width: 5.w),
                IzlayRechargeCardWidget(
                  icon: Icons.credit_card_rounded,
                  text: "Carte Bancaire",
                  pageController: pageController,
                  child: const IzlyRechargeCBPage(),
                ),
              ],
            ),
            SizedBox(height: 5.w),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IzlayRechargeCardWidget(
                icon: Icons.person_rounded,
                text: "Tiers",
                pageController: pageController,
                child: const IzlyRechargeTiersPage(),
              ),
              SizedBox(width: 5.w),
              IzlayRechargeCardWidget(
                icon: Icons.paid_rounded,
                text: "Historique des payments",
                pageController: pageController,
                child: IzlyPaidPage(),
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
