import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

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
            ? MobileScanner(onDetect: (barcode, args) {
                final String code = barcode.rawValue ?? '';
                if (code.isNotEmpty && code.startsWith('http')) {
                  Navigator.pop(context, code);
                }
              })

            // ? MobileScanner(
            //     controller: MobileScannerController(
            //       detectionSpeed: DetectionSpeed.noDuplicates,
            //     ),
            //     onDetect: (barcode) {
            //       final String code = barcode.barcodes.first.rawValue ?? '';
            //       if (code.isNotEmpty && code.startsWith('http')) {
            //         Navigator.pop(context, code);
            //       }
            //     })
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
