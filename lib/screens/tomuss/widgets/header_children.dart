import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class HeaderChildren extends StatelessWidget {
  const HeaderChildren({Key? key, required this.onTap}) : super(key: key);
  final Function(TeachingUnit teachingUnit) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      builder: (context, state) {
        final teachingUnitElements = state.newElements;
        // final teachingUnitElements = context.read<TomussCubit>().state.newElements;
        List<Widget> widgets = [];
        widgets.add(SizedBox(height: 2.h));

        for (var child in teachingUnitElements) {
          if (child.teachingUnitElement.isVisible) {
            if (child.teachingUnitElement is Grade) {
              widgets.add(
                GradeCompactWidget(
                  grade: child.teachingUnitElement as Grade,
                  teachingUnitTitle: child.teachingUnit.title,
                  onTap: () => onTap(child.teachingUnit),
                ),
              );
            } else if (child.teachingUnitElement is Enumeration) {
              widgets.add(EnumerationCompactWidget(
                enumeration: child.teachingUnitElement as Enumeration,
                teachingUnitTitle: child.teachingUnit.title,
                onTap: () => onTap(child.teachingUnit),
              ));
            } else if (child.teachingUnitElement is Presence) {
              widgets.add(PresenceCompactWidget(
                presence: child.teachingUnitElement as Presence,
                teachingUnitTitle: child.teachingUnit.title,
                onTap: () => onTap(child.teachingUnit),
              ));
            } else if (child.teachingUnitElement is TomussText) {
              widgets.add(TomussTextCompactWidget(
                text: child.teachingUnitElement as TomussText,
                teachingUnitTitle: child.teachingUnit.title,
                onTap: () => onTap(child.teachingUnit),
              ));
            } else if (child.teachingUnitElement is Upload) {
              widgets.add(UploadCompactWidget(
                upload: child.teachingUnitElement as Upload,
                teachingUnitTitle: child.teachingUnit.title,
                onTap: () => onTap(child.teachingUnit),
              ));
            } else if (child.teachingUnitElement is StageCode) {
              widgets.add(StageCodeCompactWidget(
                stageCode: child.teachingUnitElement as StageCode,
                teachingUnitTitle: child.teachingUnit.title,
                onTap: () => onTap(child.teachingUnit),
              ));
            } else if (child.teachingUnitElement is URL) {
              widgets.add(URLCompactWidget(
                url: child.teachingUnitElement as URL,
                teachingUnitTitle: child.teachingUnit.title,
                onTap: () => onTap(child.teachingUnit),
              ));
            } else {
              if (kDebugMode) {
                print("Unknown type: ${child.runtimeType}");
              }
            }
            widgets.add(SizedBox(width: 2.w));
          }
        }
        widgets.removeLast();
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: widgets,
        );
      },
    );
  }
}
