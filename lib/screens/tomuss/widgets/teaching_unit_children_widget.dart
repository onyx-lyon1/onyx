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
        List<dynamic> children = [];
        children.addAll(teachingUnit.grades);
        children.addAll(teachingUnit.enumerations);
        children.addAll(teachingUnit.presences);
        children.addAll(teachingUnit.textValues);
        children.addAll(teachingUnit.uploads);
        children.addAll(teachingUnit.stageCodes);
        children.sort((a, b) => a.position.compareTo(b.position));
        List<Widget> widgets = [];
        widgets.add(SizedBox(height: 2.h));
        for (var child in children) {
          if (child.isVisible) {
            switch (child.runtimeType) {
              case Grade:
                widgets.add(
                  GradeListWidget(
                    grades: child,
                  ),
                );
                break;
              case Enumeration:
                if (child.isVisible) {
                  widgets.add(EnumerationWidget(enumeration: child));
                }
                break;
              case Presence:
                if (child.isVisible) {
                  widgets.add(PresenceWidget(presence: child));
                }
                break;

              case TomussText:
                if (child.isVisible) {
                  widgets.add(TomussTextWidget(text: child));
                }
                break;
              case Upload:
                widgets.add(UploadWidget(upload: child));
                widgets.add(SizedBox(height: 2.h));
                break;
              case StageCode:
                widgets.add(StageCodeWidget(stageCode: child));
                break;
              case URL:
                widgets.add(URLWidget(url: child));
                break;
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
