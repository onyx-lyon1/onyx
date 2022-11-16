import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SnackBar loadingSnackbar(
    {required String message, required BuildContext context}) {
  return SnackBar(
    backgroundColor: Theme.of(context).backgroundColor,
    duration: const Duration(days: 365),
    content: Row(
      children: [
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 1.w,
        ),
        Expanded(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    ),
    action: SnackBarAction(
      label: 'Cacher',
      textColor: Theme.of(context).primaryColor,
      onPressed: () {
        // Code to execute.
      },
    ),
  );
}
