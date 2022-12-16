import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/res.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

class EmailHeaderWidget extends StatelessWidget {
  const EmailHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      height: Res.bottomNavBarHeight,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(100)),
        width: 85.w,
        height: Res.bottomNavBarHeight,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 3.w),
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
                      Icons.search,
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
          ],
        ),
      ),
    );
  }
}
