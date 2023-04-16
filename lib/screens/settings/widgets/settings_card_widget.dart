import 'package:flutter/material.dart';

class SettingsCardWidget extends StatelessWidget {
  final String name;
  final List<Widget> widgets;

  const SettingsCardWidget({
    Key? key,
    required this.name,
    required this.widgets,
  }) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ...widgets,
            ],
          ),
        ),
      );
    }
  }
}
