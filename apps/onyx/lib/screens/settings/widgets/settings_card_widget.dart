import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsCardWidget extends StatelessWidget {
  final String name;
  final List<Widget> widgets;

  const SettingsCardWidget({
    super.key,
    required this.name,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    if (widgets.isEmpty) {
      return Container();
    } else {
      return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            left: 15,
            right: 15,
            bottom: 5,
          ),
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ResponsiveGridView(
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                maxCrossAxisExtent: (!Res.isWide) ? 90.w : 30.w,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                childAspectRatio: 8 / 1,
                children: widgets,
              ),
            ],
          ),
        ),
      );
    }
  }
}
