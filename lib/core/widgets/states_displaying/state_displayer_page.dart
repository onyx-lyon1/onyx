import 'package:flutter/material.dart';
import 'package:onyx/core/widgets/states_displaying/state_displaying_widget_export.dart';
import 'package:sizer/sizer.dart';

class StateDisplayingPage extends StatelessWidget {
  final String message;

  const StateDisplayingPage({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
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
      ),
    );
  }
}
