import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:onyx/screens/tomuss/widgets/tomuss_element_widgets/enumeration_widget.dart';
import 'package:sizer/sizer.dart';

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
        List<TeachingUnitElement> children =
            teachingUnit.visibleChildren.sortByPosition();
        children.sort((a, b) => a.position.compareTo(b.position));
        List<Widget> widgets = [];
        widgets.add(SizedBox(height: 2.h));

        for (var child in children) {
          if (child.isVisible) {
            if (child is Grade) {
              widgets.add(
                GradeListWidget(
                  grades: child,
                ),
              );
            } else if (child is Enumeration) {
              widgets.add(EnumerationWidget(enumeration: child));
            } else if (child is Presence) {
              widgets.add(PresenceWidget(presence: child));
            } else if (child is TomussText) {
              widgets.add(TomussTextWidget(text: child));
            } else if (child is Upload) {
              widgets.add(UploadWidget(upload: child));
            } else if (child is StageCode) {
              widgets.add(StageCodeWidget(stageCode: child));
            } else if (child is URL) {
              widgets.add(URLWidget(url: child));
            } else {
              if (kDebugMode) {
                print("Unknown type: ${child.runtimeType}");
              }
            }
            widgets.add(SizedBox(height: 2.h));
          }
        }
        widgets.removeLast();
        return Column(
          children: widgets,
        );
      },
    );
  }
}
