import 'package:flutter/material.dart';

import 'package:printing/printing.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';

class QRCodeWidget extends StatelessWidget {
  const QRCodeWidget({required this.store, required this.model, Key? key})
      : super(key: key);

  final OrdersModel model;
  final OrdersStore store;

  Future<void> shareQRPng({required int number}) async {
    try {
      final painter = QrPainter(
        data: model.id,
        version: QrVersions.auto,
        color: const Color(0xFF000000),
        gapless: true,
        embeddedImageStyle: null,
        embeddedImage: null,
      );
      final data = await painter.toImageData(2048);
      // final tempDir = await getTemporaryDirectory();
      // final file = await File('${tempDir.path}/image.png').create();
      // final path = '${tempDir.path}/$number.png';
      final imgBytes =
          data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // final imgFile = await File(path).writeAsBytes(imgBytes);
      // Share.shareFiles(
      //   [imgFile.path],
      // );
      await Printing.layoutPdf(
          onLayout: (format) async => imgBytes, name: '$number');
      // await Printing.sharePdf(bytes: imgBytes, filename: '$number.pdf');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: RepaintBoundary(
            key: key,
            child: QrImage(
              data: model.id,
              version: QrVersions.auto,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            await shareQRPng(number: model.itemsModel.number);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Share QR",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
        // GestureDetector(onTap: (){
        // },child: Text(''),)
      ],
    );
  }
}
