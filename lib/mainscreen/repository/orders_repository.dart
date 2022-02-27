import 'dart:convert';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:http/http.dart' as http;

class OrdersRepository {
  final _newOrdersUrl = 'https://www.graduationgowns.ie/_functions/orderslist';
  final _pendingOrdersUrl =
      'https://www.graduationgowns.ie/_functions/pendingOrdersqrlist';

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

  Future<void> addPendingData({required OrdersModel model}) async {
    final userInfo = jsonEncode(model.userInfo.toMap());
    final address = jsonEncode(model.addressModel.toMap());
    final items = jsonEncode(model.itemsModel.toMap());

    final _uploadUrl =
        'https://www.graduationgowns.ie/_functions/orderDummyStatus?userInfo=$userInfo&id=${model.id}&status=${model.orderStatus.toString()}&createdAt=${model.createdAt}&address=$address&items=$items';
    final resp = await http.get(Uri.parse(_uploadUrl));
    if (resp.statusCode == 200) {
      print("Successful");
    } else {
      print('Not successful');
    }
  }

  Future<void> addCompletedData({required OrdersModel model}) async {
    final _uploadUrl =
        'https://www.graduationgowns.ie/_functions/orderDummyStatus?userInfo=${model.userInfo.toMap()..toString()}&id=${model.id}&status=${model.orderStatus.toString()}&createdAt=${model.createdAt}&address=${model.addressModel.toMap()..toString()}&items=${model.itemsModel.toMap()..toString()}';
    final resp = await http.get(Uri.parse(_uploadUrl));
    if (resp.statusCode == 200) {
      print("Successful");
    } else {
      print('Not successful');
    }
  }
}
