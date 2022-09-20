import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  QrCodeScannerState createState() => QrCodeScannerState();
}

class QrCodeScannerState extends State<QrCodeScanner> {
  late bool cameraGranted = false;

  void checkCameraPermission() async {
    cameraGranted = await Permission.camera.request().isGranted;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkCameraPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardTheme.color,
        elevation: 2,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: cameraGranted
            ? MobileScanner(
                allowDuplicates: false,
                onDetect: (barcode, args) {
                  final String code = barcode.rawValue ?? '';
                  if (code.isNotEmpty && code.startsWith('http')) {
                    Navigator.pop(context, code);
                  }
                })
            : const Center(
                child: Text(
                  /* TODO: beautify this screen !*/
                  'Nous avons besoin de la caméra pour scanner le QR code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
