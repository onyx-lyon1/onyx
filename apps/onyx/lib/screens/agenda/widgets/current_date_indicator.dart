import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget_res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CurrentDateIndicator extends StatefulWidget {
  const CurrentDateIndicator({super.key, required this.columnWidth});

  final double columnWidth;

  @override
  State<CurrentDateIndicator> createState() => _CurrentDateIndicatorState();
}

class _CurrentDateIndicatorState extends State<CurrentDateIndicator> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {});
    });
    return Positioned(
      top: (((DateTime.now().difference(DateTime.now().shrink(3)).inMinutes /
                      60) -
                  (Res.agendaDayStart.inMinutes / 60)) *
              (Res.agendaDayDuration.inHours / DaysViewRes.heightFactor).h)
          .clamp(0, double.infinity),
      child:
          // Stack(
          //   alignment: Alignment.centerLeft,
          //   children: [
          //     Container(
          //       height: 3.w,
          //       width: 3.w,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(500),
          //         color: Theme.of(context).primaryColor,
          //       ),
          //     ),
          Container(
        height: 0.8.w,
        width: widget.columnWidth,
        color: Theme.of(context).primaryColor,
      ),
      // Positioned(
      //   right: 0,
      //   child: Container(
      //     height: 3.w,
      //     width: 3.w,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(500),
      //       color: Theme.of(context).primaryColor,
      //     ),
      //   ),
      // ),
      //   ],
      // ),
    );
  }
}
