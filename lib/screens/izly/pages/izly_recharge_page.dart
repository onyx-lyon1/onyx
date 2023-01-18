import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:sizer/sizer.dart';

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
                  tag: "izly_recharge_transfer",
                  icon: Icons.compare_arrows_rounded,
                  text: "Virement",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const IzlyRechargeTranferPage())).then(
                        (value) => pageController.animateToPage(0,
                            duration: Res.animationDuration,
                            curve: Curves.easeInOut));
                  },
                ),
                SizedBox(width: 5.w),
                IzlayRechargeCardWidget(
                  tag: "izly_recharge_cb",
                  icon: Icons.credit_card_rounded,
                  text: "Carte Bancaire",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const IzlyRechargeCBPage())).then((value) =>
                        pageController.animateToPage(0,
                            duration: Res.animationDuration,
                            curve: Curves.easeInOut));
                  },
                ),
              ],
            ),
            SizedBox(height: 5.w),
            IzlayRechargeCardWidget(
              tag: "izly_recharge_tiers",
              icon: Icons.person_rounded,
              text: "Tiers",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const IzlyRechargeTiersPage())).then((value) =>
                    pageController.animateToPage(0,
                        duration: Res.animationDuration,
                        curve: Curves.easeInOut));
              },
            ),
          ],
        ),
      ],
    );
  }
}
