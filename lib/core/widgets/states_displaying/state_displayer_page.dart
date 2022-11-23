import 'package:flutter/material.dart';
import 'package:oloid2/core/widgets/states_displaying/custom_circular_progress_indicator_widget.dart';
import 'package:sizer/sizer.dart';

class StateDisplayingPage extends StatelessWidget {
  final String message;

  const StateDisplayingPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomCircularProgressIndicatorWidget(),
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
