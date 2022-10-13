import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String name;
  final List<Widget> widgets;

  const SettingsCard({
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
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                      .bodyText1!
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
