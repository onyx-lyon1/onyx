import 'package:flutter/material.dart';

SnackBar loadingSnakbar(
    {required String message, required BuildContext context}) {
  return SnackBar(
    backgroundColor: Theme.of(context).backgroundColor,
    duration: const Duration(days: 365),
    content: Row(
      children: [
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text("Chargement de $message",
            style: Theme.of(context).textTheme.bodyText1),
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
