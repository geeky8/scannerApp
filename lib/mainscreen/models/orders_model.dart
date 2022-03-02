import 'dart:convert';

import 'package:scanner/enums/status.dart';
import 'package:scanner/mainscreen/models/address_model.dart';
import 'package:scanner/mainscreen/models/items_model.dart';
import 'package:scanner/mainscreen/models/user_info_model.dart';

class OrdersModel {
  OrdersModel({
    required this.createdAt,
    required this.id,
    required this.userInfo,
    required this.addressModel,
    required this.itemsModel,
    required this.orderStatus,
    required this.number,
    required this.isCheck,
  });

  factory OrdersModel.fromJson({required Map<String, dynamic> json}) {
    UserInfoModel userInfo;
    AddressModel addressModel;
    ItemsModel itemsModel;

    // Map<String, dynamic> billingInfo = {};
    if (json['status'] == null) {
      final billingInfo = json['billingInfo'] as Map<String, dynamic>;
      userInfo = UserInfoModel.fromMap(json: billingInfo);
      addressModel = AddressModel.fromJson(address: billingInfo['address']);
      itemsModel = ItemsModel.fromJson(
          json: json['totals'], lineItems: json['lineItems']);
    } else {
      userInfo = UserInfoModel.fromMap(
          json: jsonDecode(json['userInfo'] as String) as Map<String, dynamic>);
      addressModel = AddressModel.fromJson(
          address:
              jsonDecode(json['address'] as String) as Map<String, dynamic>);
      itemsModel = ItemsModel.fromJson(
          json: jsonDecode(json['items'] as String) as Map<String, dynamic>,
          lineItems: []);
    }

    return OrdersModel(
      createdAt: json['_dateCreated'] as String,
      id: json['_id'] as String,
      userInfo: userInfo,
      number: int.parse(json['number'].toString()),
      addressModel: addressModel,
      itemsModel: itemsModel,
      orderStatus: json['status'] ?? Status.NEW.inString(),
      isCheck: false,
    );
  }

  Map<String, dynamic> toMap() {
    // print(itemsModel.toMap()..toString());

    return {
      "_dateCreated": createdAt,
      "_id": id,
      "address": jsonEncode(addressModel.toMap()),
      "items": jsonEncode(itemsModel.toMap()),
      "orderStatus": orderStatus,
    };
  }

  OrdersModel copyWith({String? status, bool? isCheck}) {
    return OrdersModel(
      userInfo: userInfo,
      id: id,
      createdAt: createdAt,
      addressModel: addressModel,
      itemsModel: itemsModel,
      number: number,
      orderStatus: status ?? orderStatus,
      isCheck: isCheck ?? this.isCheck,
    );
  }

  final String id;
  final UserInfoModel userInfo;
  final ItemsModel itemsModel;
  final AddressModel addressModel;
  final String createdAt;
  final String orderStatus;
  final int number;
  final bool isCheck;
}
