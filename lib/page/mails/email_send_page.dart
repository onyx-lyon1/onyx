import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:sizer/sizer.dart';

class EmailSendPage extends StatelessWidget {
  const EmailSendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController subjectEditor = TextEditingController();
    final TextEditingController destinationEditor = TextEditingController();
    final TextEditingController bodyEditor = TextEditingController();

    return BlocBuilder<EmailBloc, EmailState>(
      builder: (context, state) {
        return Material(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    height: 6.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 5.h,
                            child: Center(
                              child: TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.top,
                                cursorColor:
                                    Theme.of(context).textTheme.button!.color!,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .color!,
                                ),
                                decoration: InputDecoration(
                                    isDense: true,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!,
                                          width: 1),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 1,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    width: 100.w,
                    height: 6.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "a: mail.receiver",
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    height: 78.h,
                    width: 100.w,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
