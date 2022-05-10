import 'package:flutter/material.dart';

class EmailHeader extends StatelessWidget {
  final Function createEmail;
  final Function(String query) searchEmail;

  const EmailHeader({
    Key? key,
    required this.createEmail,
    required this.searchEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff2e3440),
        height: 60,
        child: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: TextField(
              onSubmitted: (String query) async => await searchEmail(query),
              style: TextStyle(
                color: Theme.of(context).textTheme.button!.color,
              ), // Color(0xffd8dee9)
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xffd8dee9),
                  )),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.create,
                color: Color(0xffd8dee9),
              ))
        ]));
  }
}
