import 'package:flutter/material.dart';
import 'package:oloid2/widget/custom_circular_progress_indicator.dart';
import 'package:sizer/sizer.dart';

class StateDisplaying extends StatelessWidget {
  final String message;

  const StateDisplaying({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomCircularProgressIndicator(),
        SizedBox(
          height: 2.h,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
