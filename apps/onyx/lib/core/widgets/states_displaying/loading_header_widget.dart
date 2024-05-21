import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingHeaderWidget extends StatelessWidget {
  final String message;
  final Duration? timeout;
  final VoidCallback? timeoutCallBack;

  const LoadingHeaderWidget(
      {super.key, required this.message, this.timeout, this.timeoutCallBack});

  @override
  Widget build(BuildContext context) {
    if (timeout != null && timeoutCallBack != null) {
      Future.delayed(timeout!, timeoutCallBack);
    }
    return AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        height: 5.h,
        width: 100.w,
        color: Theme.of(context).colorScheme.surface,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (timeout != null)
              TweenAnimationBuilder(
                  duration: timeout!,
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.linear,
                  builder: (context, double value, widget) {
                    return LinearProgressIndicator(
                      value: value,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      minHeight: 5.h,
                    );
                  }),
            Padding(
              padding: EdgeInsets.all(0.8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (timeout == null)
                    SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 7.sp,
                      ),
                    ),
                  if (timeout == null)
                    SizedBox(
                      width: 2.w,
                    ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
