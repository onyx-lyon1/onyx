import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 5,
            child: Text(enumeration.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8.sp,
                )),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 7,
            child: (enumeration.modifiable)
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
                              fontSize: 11.sp,
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
                      enumeration.value ?? "",
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 5,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                teachingUnitTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
