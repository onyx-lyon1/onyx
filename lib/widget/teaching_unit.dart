import 'package:flutter/material.dart';

class TeachingUnit extends StatelessWidget {
  late String gradeNumerator;
  late String gradeDenominator;
  late String name;
  late String teacher;
  late String group;

  TeachingUnit(
      {Key? key,
      required this.gradeNumerator,
      required this.gradeDenominator,
      required this.name,
      required this.teacher,
      required this.group})
      : super(key: key);

  TeachingUnit.empty({Key? key}) : super(key: key) {
    gradeNumerator = "18";
    gradeDenominator = "20";
    name = "Cloud Computing";
    teacher = "John DOE";
    group = "A";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          color: Color(0xff3b4252),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(children: [
        Container(
          height: 60,
          width: 90,
          decoration: BoxDecoration(color: Colors.green[500]),
          child: Stack(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                color: Colors.green[400],
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(gradeNumerator,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20))),
              Container(
                  padding: const EdgeInsets.only(top: 41),
                  width: double.infinity,
                  child: Text(gradeDenominator,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 15))),
            ],
          ),
        ),
        Container(
          height: double.infinity,
          margin: const EdgeInsets.only(left: 10),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xffd8dee9)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "$teacher • grp $group",
                  textAlign: TextAlign.start,
                  style:
                      const TextStyle(fontSize: 10, color: Color(0xffd8dee9)),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
