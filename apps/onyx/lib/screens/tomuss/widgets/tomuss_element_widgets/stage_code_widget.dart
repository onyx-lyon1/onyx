import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StageCodeWidget extends StatelessWidget {
  final StageCode stageCode;

  const StageCodeWidget({super.key, required this.stageCode});

  @override
  Widget build(BuildContext context) {
    return TomussElementWidget(
      left: Center(
        child: Text(
          stageCode.title,
          maxLines: 4,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
            fontSize: 14.sp,
          ),
        ),
      ),
      right: Stack(
        children: [
          Center(
            child: Text(
              stageCode.value,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 15.sp,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              stageCode.author,
              maxLines: 3,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
