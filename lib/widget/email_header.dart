import 'package:flutter/material.dart';

class EmailHeader extends StatelessWidget {
  EmailHeader({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchController.addListener(() {
      print(searchController.text);
    });

    return Container(
        color: const Color(0xff2e3440),
        height: 60,
        child: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Color(0xffd8dee9)),
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
