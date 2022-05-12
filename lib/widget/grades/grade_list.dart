import 'package:flutter/material.dart';

class GradeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10000,
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(itemBuilder: ((context, index) {
          return Text('heyyy');
        })));
  }
}
