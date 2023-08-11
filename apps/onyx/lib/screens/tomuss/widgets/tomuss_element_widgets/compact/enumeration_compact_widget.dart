import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EnumerationCompactWidget extends StatelessWidget {
  const EnumerationCompactWidget(
      {Key? key,
      required this.enumeration,
      required this.onTap,
      required this.teachingUnitTitle})
      : super(key: key);

  final Enumeration enumeration;
  final String teachingUnitTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      onTap: onTap,
      text1: enumeration.title,
      text3: teachingUnitTitle,
      child2: (enumeration.modifiable)
          ? PopupMenuButton(
              color: Theme.of(context).colorScheme.background,
              initialValue: enumeration.value,
              itemBuilder: (BuildContext context) {
                return enumeration.values.map((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      maxLines: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15.sp,
                      ),
                    ),
                  );
                }).toList();
              },
              onSelected: (String value) {
                context
                    .read<TomussCubit>()
                    .updateEnumerationValue(enumeration, value);
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
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 15.sp,
                  ),
                ],
              ))
          : Center(
              child: Text(
                enumeration.value ?? "",
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15.sp,
                ),
              ),
            ),
    );
  }
}
