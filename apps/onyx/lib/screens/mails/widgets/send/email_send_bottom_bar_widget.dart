import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EmailSendBottomBarWidget extends StatelessWidget {
  const EmailSendBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailSendCubit, EmailSendState>(
      builder: (context, state) {
        return SizedBox(
          height: 5.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: double.infinity,
                child: Material(
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    splashColor: Theme.of(context).cardTheme.color,
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);
                      if (result != null) {
                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();
                        // ignore: use_build_context_synchronously
                        context.read<EmailSendCubit>().addAttachments(files);
                      } else {
                        Res.logger.d("cancelled attachment");
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                      child: Icon(Icons.attach_file_rounded,
                          color: Theme.of(context).textTheme.bodySmall!.color),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  height: double.infinity,
                  alignment: AlignmentDirectional.center,
                  child: QuillSimpleToolbar(
                    configurations: QuillSimpleToolbarConfigurations(
                      controller: state.controller!,
                      multiRowsDisplay: false,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: Material(
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    splashColor: Theme.of(context).cardTheme.color,
                    onTap: () => context.read<EmailSendCubit>().sendEmail(context.read<EmailCubit>()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                      child: Icon(Icons.send_rounded,
                          color: Theme.of(context).textTheme.bodySmall!.color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
