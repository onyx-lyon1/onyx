import 'package:flutter/material.dart';
import 'package:onyx/core/widgets/common_screen_widget.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyWorkingPage extends StatelessWidget {
  const IzlyWorkingPage({Key? key, required this.callback}) : super(key: key);
  final Future<dynamic> Function() callback;

  @override
  Widget build(BuildContext context) {
    callback().then((value) => Navigator.pop(context, value));
    return SafeArea(
      child: Scaffold(
        body: CommonScreenWidget(
          header:
              const IzlyRechargeHeaderWidget(title: "En cour de rechargement"),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 5.h),
                Text(
                  "Veuillez patienter",
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
