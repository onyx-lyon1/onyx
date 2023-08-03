import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class TomussTextWidget extends StatelessWidget {
  final TomussText text;

  const TomussTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TomussElementWidget(
      left: Center(
        child: Text(
          text.title,
          maxLines: 4,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
            fontSize: 11.sp,
          ),
        ),
      ),
      right: Stack(
        children: [
          Center(
            child: Text(
              text.value,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 11.sp,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              text.author,
              maxLines: 3,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 8.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
