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
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 3.w),
        child: Center(
          child: TextField(
            onChanged: (String query) {
              print("filter on query: $query");
              context.read<EmailCubit>().filter(filter: query);
            },
            onSubmitted: (String query) {
              FocusScope.of(context).unfocus();
            },
            style: TextStyle(
              color: Theme.of(context).textTheme.labelLarge!.color,
            ),
            cursorColor: Theme.of(context).textTheme.bodyLarge!.color,
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
