import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailSendAttachmentWidget extends StatefulWidget {
  const MailSendAttachmentWidget({super.key, required this.attachments});
  final List<File> attachments;

  @override
  State<MailSendAttachmentWidget> createState() =>
      _MailSendAttachmentWidgetState();
}

class _MailSendAttachmentWidgetState extends State<MailSendAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      padding: EdgeInsets.all(0.5.h),
      height: 14.h,
      width: 100.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.attachments.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return MailAttachmentWidget(
              icon: Icons.add_rounded,
              fileName: "Ajouter\n une pièce jointe",
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);
                if (result != null) {
                  List<File> files =
                      result.paths.map((path) => File(path!)).toList();
                  setState(() {
                    for (File file in files) {
                      if (!widget.attachments
                          .any((element) => element.path == file.path)) {
                        widget.attachments.add(file);
                      }
                    }
                  });
                } else {
                  Res.logger.d("cancelled attachment");
                }
              },
            );
          } else {
            return MailAttachmentWidget(
              fileName: widget.attachments[index - 1].path.split("/").last,
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (_) => SaveOrOpenDialogWidget(
                    filePath: widget.attachments[index - 1].path,
                  ),
                );
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text("Supprimer la pièce jointe ?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              child: const Text("Annuler",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.attachments.removeAt(index - 1);
                                });
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              child: const Text(
                                "Supprimer",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ));
              },
            );
          }
        },
      ),
    );
  }
}
