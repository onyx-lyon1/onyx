import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EnumerationWidget extends StatelessWidget {
  const EnumerationWidget({super.key, required this.enumeration});

  final Enumeration enumeration;

  @override
  Widget build(BuildContext context) {
    return TomussElementWidget(
      left: (enumeration.modifiable)
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
                        color: Theme.of(context).textTheme.bodyLarge!.color,
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
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 15.sp,
                    color: Colors.white,
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
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15.sp,
                ),
              ),
            ),
      right: Stack(
        children: [
          Center(
            child: Text(
              enumeration.title,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 15.sp,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "${enumeration.author}\n${enumeration.comment}".trim(),
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
