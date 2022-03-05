import 'dart:convert';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:io' as File;

class OrdersRepository {
  final _newOrdersUrl = 'https://www.graduationgowns.ie/_functions/orderslist';
  final _pendingOrdersUrl =
      'https://www.graduationgowns.ie/_functions/pendingOrdersqrlist';
  final _completedOrdersUrl =
      'https://www.graduationgowns.ie/_functions/completedOrdersqrlist';

  Future<List<OrdersModel>> getNewOrdersList() async {
    final list = <OrdersModel>[];

    final resp = await http.get(Uri.parse(_newOrdersUrl));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      // print(jsonDecode(resp.body));
      for (final i in data) {
        final model = OrdersModel.fromJson(
          json: i,
        );
        list.add(model);
      }
    }
    return list;
  }

  Future<List<OrdersModel>> getPendingOrdersList() async {
    final list = <OrdersModel>[];

    final resp = await http.get(Uri.parse(_pendingOrdersUrl));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      for (final i in data) {
        final model = OrdersModel.fromJson(json: i);
        list.add(model);
      }
    } else {
      return <OrdersModel>[];
    }
    return list;
  }

  Future<List<OrdersModel>> getCompletedOrdersList() async {
    final list = <OrdersModel>[];

    final resp = await http.get(Uri.parse(_completedOrdersUrl));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      for (final i in data) {
        final model = OrdersModel.fromJson(json: i);
        list.add(model);
      }
    } else {
      return <OrdersModel>[];
    }
    return list;
  }

  // Future<void> uploadDummyData({required OrdersModel model}) async {
  //   final _uploadUrl =
  //       'https://www.graduationgowns.ie/_functions/orderDummyStatus?userInfo=${model.userInfo.toMap()..toString()}&id=${pendingModel.id}&status=${pendingModel.orderStatus.toString()}&createdAt=${pendingModel.createdAt}&address=${model.addressModel.toMap()..toString()}&items=${model.itemsModel.toMap()..toString()}';
  //   final resp = await http.get(Uri.parse(_uploadUrl));
  //   if (resp.statusCode == 200) {
  //     print("Successful");
  //   } else {
  //     print('Not successful');
  //   }
  // }

  Future<void> moveData({required OrdersModel model}) async {
    final userInfo = jsonEncode(model.userInfo.toMap());
    final address = jsonEncode(model.addressModel.toMap());
    final items = jsonEncode(model.itemsModel.toMap());

    final _uploadUrl =
        'https://www.graduationgowns.ie/_functions/orderDummyStatus?userInfo=$userInfo&id=${model.id}&status=${model.orderStatus.toString()}&createdAt=${model.createdAt}&address=$address&items=$items&number=${model.number}';
    final resp = await http.get(Uri.parse(_uploadUrl));
    if (resp.statusCode == 200) {
      print("Successful");
    } else {
      print('Not successful');
    }
  }

  Future<OrdersModel?> getUserDetail({required String id}) async {
    final _url =
        'https://www.graduationgowns.ie/_functions/orderqrdetail?id=$id';
    final resp = await http.get(Uri.parse(_url));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final model = OrdersModel.fromJson(json: data);
      return model;
    } else {
      return null;
    }
  }

  // Future<void> addCompletedData({required OrdersModel model}) async {
  //   final _uploadUrl =
  //       'https://www.graduationgowns.ie/_functions/orderDummyStatus?userInfo=${model.userInfo.toMap()..toString()}&id=${model.id}&status=${model.orderStatus.toString()}&createdAt=${model.createdAt}&address=${model.addressModel.toMap()..toString()}&items=${model.itemsModel.toMap()..toString()}';
  //   final resp = await http.get(Uri.parse(_uploadUrl));
  //   if (resp.statusCode == 200) {
  //     print("Successful");
  //   } else {
  //     print('Not successful');
  //   }
  // }

  Future<ByteData?> toImage({required String data}) async {
    final painter =
        QrPainter(data: data, version: QrVersions.auto, gapless: true);
    final image = await painter.toImageData(1000);
    return image;
  }

  pw.Document createPDF({List<ByteData>? imageData}) {
    final pdf = pw.Document();
    for (var img in imageData!) {
      final image = pw.MemoryImage(
          img.buffer.asUint8List(img.offsetInBytes, img.lengthInBytes));
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }

    return pdf;
  }

  Future<File.File> fileConverter({required pw.Document pdf}) async {
    final output = await getTemporaryDirectory();
    final file = File.File('${output.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
