import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

import 'enumeration_widget.dart';

class TeachingUnitChildrenWidget extends StatelessWidget {
  const TeachingUnitChildrenWidget({Key? key, required this.teachingUnit})
      : super(key: key);
  final TeachingUnit teachingUnit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      buildWhen: (previous, current) =>
          listEquals(previous.teachingUnits, current.teachingUnits),
      builder: (context, state) {
        List<dynamic> children = [];
        children.addAll(teachingUnit.grades);
        children.addAll(teachingUnit.enumerations);
        children.addAll(teachingUnit.presences);
        children.addAll(teachingUnit.textValues);
        children.addAll(teachingUnit.uploads);
        children.addAll(teachingUnit.stageCodes);
        children.sort((a, b) => a.position.compareTo(b.position));
        List<Widget> widgets = [];
        for (var child in children) {
          if (child is Grade) {
            widgets.add(
              GradeListWidget(
                grades: child,
              ),
            );
          } else if (child is Enumeration) {
            widgets.add(EnumerationWidget(enumeration: child));
          } else if (child is Presence) {
            // widgets.add(PresenceWidget(presence: child));
          } else if (child is TomussText) {
            // widgets.add(TomussTextWidget(text: child));
          } else if (child is Upload) {
            // widgets.add(UploadWidget(upload: child));
          } else if (child is StageCode) {
            // widgets.add(StageCodeWidget(stageCode: child));
          }
        }
        return Column(
          children: widgets,
        );
      },
    );
  }
}
