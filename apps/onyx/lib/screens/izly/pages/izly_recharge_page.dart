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
        Center(
          child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 30.w,
              childAspectRatio: 1,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.w,
            ),
            padding: EdgeInsets.all(20.w),
            children: [
              IzlayRechargeCardWidget(
                icon: Icons.compare_arrows_rounded,
                text: "Virement",
                pageController: pageController,
                child: const IzlyRechargeTranferPage(),
              ),
              IzlayRechargeCardWidget(
                icon: Icons.credit_card_rounded,
                text: "Carte Bancaire",
                pageController: pageController,
                child: const IzlyRechargeCBPage(),
              ),
              IzlayRechargeCardWidget(
                icon: Icons.person_rounded,
                text: "Tiers",
                pageController: pageController,
                child: const IzlyRechargeTiersPage(),
              ),
              IzlayRechargeCardWidget(
                icon: Icons.paid_rounded,
                text: "Historique des paiements",
                pageController: pageController,
                child: const IzlyPaymentHistory(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
