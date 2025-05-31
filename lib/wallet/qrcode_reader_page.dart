import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

typedef OnScanned = void Function(String? address);

class QRCodeReaderPage extends StatefulWidget {
  const QRCodeReaderPage({
    Key? key,
    required this.title,
    this.onScanned,
    this.closeWhenScanned = true,
  }) : super(key: key);

  final OnScanned? onScanned;
  final bool closeWhenScanned;
  final String title;

  @override
  State<StatefulWidget> createState() => _QRCodeReaderPageState();
}

class _QRCodeReaderPageState extends State<QRCodeReaderPage> {
  static final RegExp _basicAddress =
      RegExp(r'^(0x)?[0-9a-f]{40}', caseSensitive: false);

  final MobileScannerController _controller = MobileScannerController();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller.stop();
      _controller.start();
    } else if (Platform.isIOS) {
      _controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: MobileScanner(
              controller: _controller,
              fit: BoxFit.cover,
              onDetect: (capture) {
                final barcode =
                    capture.barcodes.isNotEmpty ? capture.barcodes.first : null;
                final rawValue = barcode?.rawValue?.replaceAll('ethereum:', '');

                if (rawValue == null || !_basicAddress.hasMatch(rawValue))
                  return;

                widget.onScanned?.call(rawValue);

                if (widget.closeWhenScanned) {
                  _controller.stop();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              },
              overlay: _buildOverlay(scanArea),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay(double scanArea) {
    return CustomPaint(
      foregroundPainter: ScannerOverlayPainter(scanArea),
      child: Container(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final double cutOutSize;

  ScannerOverlayPainter(this.cutOutSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withAlpha(100);

    final borderPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;
    final cutOut = Rect.fromCenter(
      center: Offset(width / 2, height / 2),
      width: cutOutSize,
      height: cutOutSize,
    );

    // Shadow area
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, width, height)),
        Path()..addRect(cutOut),
      ),
      paint,
    );

    // Border box
    canvas.drawRect(cutOut, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
