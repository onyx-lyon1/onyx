import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingHeaderWidget extends StatelessWidget {
  final String message;

  const LoadingHeaderWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        height: 5.h,
        width: 100.w,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(0.8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 5.w,
              height: 5.w,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: 2.sp,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
