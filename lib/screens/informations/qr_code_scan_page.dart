import 'dart:io';

import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/informations/validate_qr_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanPage extends StatefulWidget {
  const QrCodeScanPage({Key? key, required this.userProfile}) : super(key: key);

  final UserProfile userProfile;

  @override
  State<QrCodeScanPage> createState() => _QrCodeScanPageState();
}

class _QrCodeScanPageState extends State<QrCodeScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderRadius: 8,
          borderLength: 20,
          borderColor: Theme.of(context).primaryColor,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
      userProfile: widget.userProfile,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();

      final Barcode result = scanData;
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => ValidateQRCode(
                qrValue: result.code.toString(),
                userProfile: widget.userProfile,
              ),
            ),
          )
          .then(
            (value) => controller.resumeCamera(),
          );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
}
