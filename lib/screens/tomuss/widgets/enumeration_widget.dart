import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class EnumerationWidget extends StatelessWidget {
  const EnumerationWidget({Key? key, required this.enumeration})
      : super(key: key);

  final Enumeration enumeration;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      builder: (context, state) {
        print("building");
        if (this.enumeration.modifiable) {
          print(context
              .read<TomussCubit>()
              .state
              .teachingUnits
              .firstWhere((element) =>
                  element.enumerations.isNotEmpty &&
                  element.enumerations
                          .indexWhere((element2) => element2.modifiable) !=
                      -1)
              .enumerations
              .where((element) => element.modifiable)
              .map((e) => e.value));
        }

        Enumeration? enumeration;
        for (var i in state.teachingUnits) {
          for (var j in i.enumerations) {
            if (j == this.enumeration) {
              enumeration = j;
            }
          }
        }
        enumeration ??= this.enumeration;
        if (this.enumeration.modifiable || enumeration.modifiable) {
          print("!!!!!!!!!!!!!!!!!${this.enumeration.value}");
          print("!!!!!!!!!!!!!!!!!${enumeration.value}");
        }
        return TomussElementWidget(
          left: (enumeration.modifiable)
              ? PopupMenuButton(
                  color: Theme.of(context).colorScheme.background,
                  initialValue: enumeration.value,
                  itemBuilder: (BuildContext context) {
                    return enumeration!.values.map((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 11.sp,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  onSelected: (String value) {
                    print("!!!!!!!!!!!!!!!!!Selected $value");
                    context
                        .read<TomussCubit>()
                        .updateEnumerationValue(enumeration!, value);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          enumeration.value ?? "",
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 11.sp,
                      ),
                    ],
                  ))
              : Center(
                  child: Text(
                    enumeration.values.last,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
          right: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                enumeration.title,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 11.sp,
                ),
              ),
              Text(
                "${enumeration.author}\n${enumeration.comment}",
                maxLines: 3,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 7.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
