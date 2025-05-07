import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:onyx/screens/tomuss/widgets/tomuss_element_widgets/enumeration_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:onyx/l10n/app_localizations.dart';

class TeachingUnitChildrenWidget extends StatelessWidget {
  const TeachingUnitChildrenWidget({super.key, required this.teachingUnit});

  final TeachingUnit teachingUnit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      buildWhen: (previous, current) =>
          listEquals(previous.teachingUnits, current.teachingUnits),
      builder: (context, state) {
        List<TeachingUnitElement> children =
            teachingUnit.visibleChildren.sortByPosition();
        List<Widget> widgets = [];

        for (var child in children) {
          if (child.isVisible) {
            if (child is Grade) {
              if (Device.orientation == Orientation.portrait) {
                widgets.add(
                  GradeListWidget(
                    grades: child,
                  ),
                );
              } else {
                widgets.addAll(constructGradeChildrenFullList(child,
                    appLocalizations: AppLocalizations.of(context)));
              }
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
              Res.logger.e("Unknown type: ${child.runtimeType}");
            }
          }
        }
        return ResponsiveGridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          maxCrossAxisExtent: (!Res.isWide) ? 70.w : 70.h,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 1,
          //3=width 1=height
          children: widgets,
        );
      },
    );
  }

  List<Widget> constructGradeChildrenFullList(Grade grade,
      {int depth = 1,
      List<Widget>? widgets,
      required AppLocalizations appLocalizations}) {
    widgets ??= [];
    widgets.add(
      GradeWidget(
        grades: [grade],
        isSeen: true,
        text1: grade.title.replaceAll("_", " "),
        text2: appLocalizations.noteDescription(grade.average, grade.mediane,
            grade.rank + 1, grade.groupeSize, grade.author),
        depth: 1,
      ),
    );
    if (grade.children.isNotEmpty) {
      for (var child in grade.children) {
        constructGradeChildrenFullList(child,
            depth: depth + 1,
            widgets: widgets,
            appLocalizations: appLocalizations);
      }
    }
    return widgets;
  }
}
