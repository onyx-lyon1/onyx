import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sizer/sizer.dart';

class SaveOrOpenDialogWidget extends StatelessWidget {
  const SaveOrOpenDialogWidget({Key? key, required this.filePath}) : super(key: key);
  final String filePath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        'Enregistrer ou ouvrir le fichier',
        style: TextStyle(fontSize: 20.sp),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              OpenFilex.open(filePath);
              Navigator.pop(context);
            },
            child: Text(
              'Ouvrir',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 13.sp),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                FlutterFileDialog.saveFile(
                        params: SaveFileDialogParams(sourceFilePath: filePath))
                    .then((value) => Navigator.pop(context));
              } else if (Platform.isWindows ||
                  Platform.isLinux ||
                  Platform.isMacOS) {
                FilePicker.platform
                    .saveFile(
                  dialogTitle: 'Please select an output file:',
                  fileName: filePath.split('/').last,
                )
                    .then((outputFilePath) {
                  if (outputFilePath != null) {
                    File outputFile = File(outputFilePath);
                    File inputFile = File(filePath);
                    outputFile.writeAsBytesSync(inputFile.readAsBytesSync());
                  }
                  Navigator.pop(context);
                });
              }
            },
            child: Text(
              'Enregistrer',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
