import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:sizer/sizer.dart';

class EmailHeader extends StatelessWidget {
  const EmailHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      height: 10.h,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        width: 85.w,
        height: 10.h,
        child: TextField(
          onChanged: (String query) {
            context.read<EmailBloc>().add(EmailFilter(query));
          },
          style: TextStyle(
            color: Theme.of(context).textTheme.button!.color,
          ),
          cursorColor: Theme.of(context).textTheme.bodyText1!.color,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
          ),
        ),
      ),
    );
  }
}
