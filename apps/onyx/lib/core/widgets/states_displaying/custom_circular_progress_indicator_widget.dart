import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCircularProgressIndicatorWidget extends StatelessWidget {
  const CustomCircularProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 25.w,
            width: 25.w,
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )));
  }
}
