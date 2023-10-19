import 'package:flutter/material.dart';

class IzlyRechargeHeaderWidget extends StatelessWidget {
  const IzlyRechargeHeaderWidget({super.key, required this.title});
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
