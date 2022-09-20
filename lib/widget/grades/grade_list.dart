import 'package:flutter/material.dart';

class GradeList extends StatelessWidget {
  const GradeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10000,
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(itemBuilder: ((context, index) {
          return const Text('heyyy');
        })));
  }
}


