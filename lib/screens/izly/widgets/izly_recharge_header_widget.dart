import 'package:flutter/material.dart';

class IzlyRechargeHeaderWidget extends StatelessWidget {
  const IzlyRechargeHeaderWidget({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(title),
        Positioned(
          left: 0,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        )
      ],
    );
  }
}
