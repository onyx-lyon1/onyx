import 'package:flutter/material.dart';

class TextSwitch extends StatefulWidget {
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
  State<StatefulWidget> createState() {
    return _TextSwitchState();
  }
}

class _TextSwitchState extends State<TextSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => widget.onChanged(!widget.value),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 150,
            child: Text(
              widget.text,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Switch(
          activeColor: Theme.of(context).primaryColor,
          value: widget.value,
          onChanged: (bool b) => widget.onChanged(b),
        ),
      ],
    );
  }
}
