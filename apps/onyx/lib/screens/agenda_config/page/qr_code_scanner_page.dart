import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({super.key});

  @override
  QrCodeScannerPageState createState() => QrCodeScannerPageState();
}

class QrCodeScannerPageState extends State<QrCodeScannerPage> {
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: cameraGranted
            ? QRCodeDartScanView(
                scanInvertedQRCode: true,
                typeScan: TypeScan.live,
                onCapture: (result) {
                  if (result.text.isNotEmpty &&
                      result.text.startsWith('http')) {
                    Navigator.pop(context, result.text);
                  }
                },
              )
            : Center(
                child: Text(
                  AppLocalizations.of(context).needCameraToScanQrCode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
