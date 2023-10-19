import 'package:flutter/material.dart';
import 'package:onyx/core/widgets/states_displaying/state_displaying_widget_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StateDisplayingPage extends StatelessWidget {
  final String message;

  const StateDisplayingPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomCircularProgressIndicatorWidget(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
