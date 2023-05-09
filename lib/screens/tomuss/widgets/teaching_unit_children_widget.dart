import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

import 'enumeration_widget.dart';

class TeachingUnitChildrenWidget extends StatelessWidget {
  const TeachingUnitChildrenWidget({Key? key, required this.teachingUnit})
      : super(key: key);
  final TeachingUnit teachingUnit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      builder: (context, state) {
        return Column(
          children: [
            GradeListWidget(
              grades: teachingUnit.grades,
              depth: 1,
              lastElement: true,
            ),
            for (var i in teachingUnit.enumerations)
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: EnumerationWidget(
                  enumeration: i,
                ),
              ),
          ],
        );
      },
    );
  }
}
