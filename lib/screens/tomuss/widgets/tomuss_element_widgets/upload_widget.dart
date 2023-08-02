import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sizer/sizer.dart';

class UploadWidget extends StatelessWidget {
  final Upload upload;

  const UploadWidget({super.key, required this.upload});

  @override
  Widget build(BuildContext context) {
    return TomussElementWidget(
      left: Row(
        children: [
          IconButton(
              onPressed: () async {
                final String path = await TomussLogic.getDownloadLocalPath(
                  upload: upload,
                  ticket: context
                      .read<TomussCubit>()
                      .state
                      .teachingUnits
                      .firstWhere((element) => element.uploads.contains(upload))
                      .ticket,
                  context: context,
                );
                OpenFilex.open(path);
              },
              icon: const Icon(
                Icons.open_in_new_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                final String path = await TomussLogic.getDownloadLocalPath(
                  upload: upload,
                  ticket: context
                      .read<TomussCubit>()
                      .state
                      .teachingUnits
                      .firstWhere((element) => element.uploads.contains(upload))
                      .ticket,
                  context: context,
                );
                if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                  FlutterFileDialog.saveFile(
                          params: SaveFileDialogParams(sourceFilePath: path))
                      .then((value) => Navigator.pop(context));
                } else if (!kIsWeb &&
                    (Platform.isWindows ||
                        Platform.isLinux ||
                        Platform.isMacOS)) {
                  FilePicker.platform
                      .saveFile(
                    dialogTitle: 'Please select an output file:',
                    fileName: path.split('/').last,
                  )
                      .then((outputFilePath) {
                    if (outputFilePath != null) {
                      File outputFile = File(outputFilePath);
                      File inputFile = File(path);
                      outputFile.writeAsBytesSync(inputFile.readAsBytesSync());
                    }
                    // Navigator.pop(context);
                  });
                }
              },
              icon: const Icon(
                Icons.save_rounded,
                color: Colors.white,
              )),
        ],
      ),
      right: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            upload.title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              overflow: TextOverflow.ellipsis,
              fontSize: 11.sp,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "${upload.author}\n${upload.comment}",
              maxLines: 3,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 8.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
