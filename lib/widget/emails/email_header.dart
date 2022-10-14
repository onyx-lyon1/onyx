import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/functionalities/email/email_bloc.dart';
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.hardEdge,
        width: 85.w,
        height: 10.h,
        child: TextField(

          // expands: true,
          onChanged: (String query) {
            context.read<EmailBloc>().add(EmailSort(query));
          },
          style: TextStyle(
            color: Theme.of(context).textTheme.button!.color,
          ),
          cursorColor: Theme.of(context).textTheme.bodyText1!.color,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).backgroundColor,
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
