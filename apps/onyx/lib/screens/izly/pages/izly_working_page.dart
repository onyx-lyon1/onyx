import 'package:flutter/material.dart';
import 'package:onyx/core/widgets/common_screen_widget.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:onyx/l10n/app_localizations.dart';

class IzlyWorkingPage extends StatelessWidget {
  const IzlyWorkingPage({super.key, required this.callback});

  final Future<dynamic> Function() callback;

  @override
  Widget build(BuildContext context) {
    callback().then((value) => Navigator.pop(context, value));
    return SafeArea(
      child: Scaffold(
        body: CommonScreenWidget(
          header: IzlyRechargeHeaderWidget(
              title: AppLocalizations.of(context).recharging),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 5.h),
                Text(
                  AppLocalizations.of(context).pleaseWait,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
