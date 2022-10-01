import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/page/pages.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:sizer/sizer.dart';

class EmailHeader extends StatelessWidget {
  const EmailHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff2e3440),
      height: 10.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            clipBehavior: Clip.hardEdge,
            width: 85.w,
            child: TextField(
              onChanged: (String query) {
                context.read<EmailBloc>().add(EmailSort(query));
              },
              style: TextStyle(
                color: Theme.of(context).textTheme.button!.color,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color.fromARGB(255, 38, 43, 53),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffd8dee9),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EmailSendPage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.create,
                  color: const Color(0xffd8dee9),
                  size: 25.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
