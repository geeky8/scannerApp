import 'dart:convert';

import 'package:scanner/enums/status.dart';
import 'package:scanner/mainscreen/models/address_model.dart';
import 'package:scanner/mainscreen/models/items_model.dart';
import 'package:scanner/mainscreen/models/user_info_model.dart';

class UpdatedOrdersModel {
  UpdatedOrdersModel({
    required this.createdAt,
    required this.id,
    required this.userInfo,
    required this.addressModel,
    required this.itemsModel,
    required this.orderStatus,
  });

  factory UpdatedOrdersModel.frommap({required Map<String, dynamic> map}) {
    final userInfo = UserInfoModel.fromMap(
        json: jsonDecode(map['userInfo']) as Map<String, dynamic>);
    final addressModel = AddressModel.fromJson(
        address: jsonDecode(map['address']) as Map<String, dynamic>);
    final itemsModel =
        ItemsModel.fromJson(json: map, lineItems: map['productModelList']);
    return UpdatedOrdersModel(
      createdAt: map['_dateCreated'] as String,
      id: map['_id'] as String,
      userInfo: userInfo,
      addressModel: addressModel,
      itemsModel: itemsModel,
      orderStatus: map['status'] ?? Status.NEW.inString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_dateCreated": createdAt,
      "_id": id,
      "address": addressModel.toMap(),
      "items": itemsModel.toMap(),
      "orderStatus": orderStatus,
    };
  }

  UpdatedOrdersModel copyWith({required String status}) {
    return UpdatedOrdersModel(
      userInfo: userInfo,
      id: id,
      createdAt: createdAt,
      addressModel: addressModel,
      itemsModel: itemsModel,
      orderStatus: status,
    );
  }

  final String id;
  final UserInfoModel userInfo;
  final ItemsModel itemsModel;
  final AddressModel addressModel;
  final String createdAt;
  final String orderStatus;
}
