import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

class EmailHeaderWidget extends StatelessWidget {
  const EmailHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 3.w),
        child: Center(
          child: TextField(
            onChanged: (String query) {
              context.read<EmailCubit>().filter(filter: query);
            },
            style: TextStyle(
              color: Theme.of(context).textTheme.button!.color,
            ),
            cursorColor: Theme.of(context).textTheme.bodyText1!.color,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText:
                  "Recherche dans les ${context.read<EmailCubit>().emailNumber} derniers mails",
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
