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
      for (final i in data) {
        final model = OrdersModel.fromJson(json: i);
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
    }
    return list;
  }

  Future<void> uploadDummyData({required OrdersModel model}) async {
    final _uploadUrl =
        'https://www.graduationgowns.ie/_functions/orderDummyInsert?firstName=${model.firstName}&createdAt=${model.createdAt}&email=${model.email}&lastName=${model.lastName}&id=${model.id}&contact=${model.contact}&address=${model.addressModel.toMap()}&items=${model.itemsModel.toMap()}&orderStatus=${model.orderStatus}';
    final resp = await http.get(Uri.parse(_uploadUrl));
    if (resp.statusCode == 200) {
      print("Successful");
    } else {
      print('Not successful');
    }
  }

  Future<void> addPendingData({required OrdersModel model}) async {
    print(model.orderStatus);
    final _uploadUrl =
        'https://www.graduationgowns.ie/_functions/orderqrinsert?firstName=${model.firstName}&createdAt=${model.createdAt}&email=${model.email}&lastName=${model.lastName}&id=${model.id}&contact=${model.contact}&address=${model.addressModel.toMap()}&items=${model.itemsModel.toMap()}&orderStatus=new';
    final resp = await http.get(Uri.parse(_uploadUrl));
    if (resp.statusCode == 200) {
      print("Successful");
    } else {
      print('Not successful');
      print(resp.reasonPhrase);
      print(resp.headers);
    }
  }
}
