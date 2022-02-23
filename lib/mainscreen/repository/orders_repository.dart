import 'dart:convert';

import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:http/http.dart' as http;

class OrdersRepository {
  final _newOrdersUrl = 'https://www.graduationgowns.ie/_functions/orderslist';

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
}
