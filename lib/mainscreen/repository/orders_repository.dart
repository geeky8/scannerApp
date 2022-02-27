import 'dart:convert';

import 'package:scanner/enums/status.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:http/http.dart' as http;
import 'package:scanner/mainscreen/models/updated_orders_model.dart';

class OrdersRepository {
  final _newOrdersUrl = 'https://www.graduationgowns.ie/_functions/orderslist';
  final _pendingOrdersUrl =
      'https://www.graduationgowns.ie/_functions/pendingOrdersqrlist';

  Future<List<OrdersModel>> getNewOrdersList() async {
    final list = <OrdersModel>[];

    final resp = await http.get(Uri.parse(_newOrdersUrl));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      print(jsonDecode(resp.body));
      for (final i in data) {
        final model = OrdersModel.fromJson(json: i);
        list.add(model);
      }
    }
    return list;
  }

  Future<List<UpdatedOrdersModel>> getPendingOrdersList() async {
    final list = <UpdatedOrdersModel>[];

    final resp = await http.get(Uri.parse(_pendingOrdersUrl));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      for (final i in data) {
        final model = UpdatedOrdersModel.frommap(map: i);
        list.add(model);
      }
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
    final _uploadUrl =
        'https://www.graduationgowns.ie/_functions/orderDummyStatus?userInfo=${model.userInfo.toMap()}&id=${model.id}&status=${model.orderStatus.toString()}&createdAt=${model.createdAt}&address=${model.addressModel.toMap()}&items=${model.itemsModel.toMap()}';
    final resp = await http.get(Uri.parse(_uploadUrl));
    if (resp.statusCode == 200) {
      print("Successful");
    } else {
      print('Not successful');
    }
  }

  Future<void> addCompletedData({required UpdatedOrdersModel model}) async {
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
