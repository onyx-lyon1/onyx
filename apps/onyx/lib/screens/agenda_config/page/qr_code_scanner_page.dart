import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({Key? key}) : super(key: key);

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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        color: Theme.of(context).colorScheme.background,
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
