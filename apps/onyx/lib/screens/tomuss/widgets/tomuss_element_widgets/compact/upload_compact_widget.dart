import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UploadCompactWidget extends StatelessWidget {
  final Upload upload;
  final Function()? onTap;
  final String teachingUnitTitle;

  const UploadCompactWidget(
      {super.key,
      required this.upload,
      required this.onTap,
      required this.teachingUnitTitle});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      text1: upload.title,
      text3: teachingUnitTitle,
      onTap: onTap,
      child2: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: IconButton(
                onPressed: () async {
                  final String path = await TomussLogic.getDownloadLocalPath(
                    upload: upload,
                    ticket: context
                        .read<TomussCubit>()
                        .state
                        .teachingUnits
                        .firstWhere(
                            (element) => element.uploads.contains(upload))
                        .ticket,
                    context: context,
                  );
                  OpenFilex.open(path);
                },
                icon: const Icon(
                  Icons.open_in_new_rounded,
                )),
          ),
          Flexible(
            child: IconButton(
                onPressed: () async {
                  final String path = await TomussLogic.getDownloadLocalPath(
                    upload: upload,
                    ticket: context
                        .read<TomussCubit>()
                        .state
                        .teachingUnits
                        .firstWhere(
                            (element) => element.uploads.contains(upload))
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
                      dialogTitle:
                          // ignore: use_build_context_synchronously
                          AppLocalizations.of(context).pleaseSelectOutputFile,
                      fileName: path.split('/').last,
                    )
                        .then((outputFilePath) {
                      if (outputFilePath != null) {
                        File outputFile = File(outputFilePath);
                        File inputFile = File(path);
                        outputFile
                            .writeAsBytesSync(inputFile.readAsBytesSync());
                      }
                      // Navigator.pop(context);
                    });
                  }
                },
                icon: const Icon(
                  Icons.save_rounded,
                )),
          ),
        ],
      ),
    );
  }
}
