import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final String text;
  final List<String> items;
  final void Function(int b) onChanged;
  final int value;

  const DropDownWidget({
    Key? key,
    required this.text,
    required this.items,
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
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: 12,
            ),
          ),
        ),
        DropdownButton(
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: items.indexOf(e),
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) => onChanged(value as int),
          value: value,
          borderRadius: BorderRadius.circular(10),
          dropdownColor: Theme.of(context).colorScheme.background,
          focusColor: Theme.of(context).cardTheme.color,
        ),
      ],
    );
  }
}
