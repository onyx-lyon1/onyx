import 'package:flutter/material.dart';

class TextSwitch extends StatelessWidget {
  final String text;
  final Function(bool b) onChanged;
  final bool value;

  const TextSwitch({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 150,
          child: Text(
            text,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ),
        Switch(
          activeColor: Theme.of(context).primaryColor,
          value: value,
          onChanged: (bool b) => onChanged(b),
        ),
      ],
    );
  }
}
