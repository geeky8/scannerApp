import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';
import 'package:scanner/mainscreen/utils/constants.dart';

class GenrateQRButton extends StatelessWidget {
  const GenrateQRButton({
    Key? key,
    required this.store,
  }) : super(key: key);

  final OrdersStore store;

  // Future<ByteData?> toImage({required String data}) async {
  //   final painter =
  //       QrPainter(data: data, version: QrVersions.auto, gapless: true);
  //   final image = await painter.toImageData(2048);
  //   return image;
  // }

  // pw.Document createPDF({List<ByteData>? imageData}) {
  //   final pdf = pw.Document();
  //   for (var img in imageData!) {
  //     final image = pw.MemoryImage(
  //         img.buffer.asUint8List(img.offsetInBytes, img.lengthInBytes));
  //     pdf.addPage(pw.Page(
  //         pageFormat: PdfPageFormat.a4,
  //         build: (pw.Context contex) {
  //           return pw.Center(child: pw.Image(image));
  //         }));
  //   }

  //   return pdf;
  // }

  // Future<File.File> fileConverter({required pw.Document pdf}) async {
  //   final output = await getTemporaryDirectory();
  //   final file = File.File('${output.path}/example.pdf');
  //   await file.writeAsBytes(await pdf.save());
  //   return file;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await store.generateQRCodes();
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        padding: const EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 1.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Observer(builder: (_) {
          final state = store.buttonState;

          switch (state) {
            case ButtonState.LOADING:
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            case ButtonState.SUCCESS:
              return const Text(
                'Generate QR codes',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              );
            case ButtonState.APPLIED:
              return const SizedBox();
          }
        }),
      ),
    );
  }
}
