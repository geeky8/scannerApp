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
  });

  factory OrdersModel.fromJson({required Map<String, dynamic> json}) {
    final billingInfo = json['billingInfo'] as Map<String, dynamic>;
    final userInfo = UserInfoModel.fromMap(json: billingInfo);
    final addressModel = AddressModel.fromJson(address: billingInfo['address']);
    final itemsModel =
        ItemsModel.fromJson(json: json['totals'], lineItems: json['lineItems']);
    return OrdersModel(
      createdAt: json['_dateCreated'] as String,
      id: json['_id'] as String,
      userInfo: userInfo,
      addressModel: addressModel,
      itemsModel: itemsModel,
      orderStatus: json['status'] ?? Status.NEW.inString(),
    );
  }

  Map<String, dynamic> toMap() {
    // print(itemsModel.toMap()..toString());

    return {
      "_dateCreated": createdAt,
      "_id": id,
      "address": addressModel.toMap(),
      "items": itemsModel.toMap(),
      "orderStatus": orderStatus,
    };
  }

  OrdersModel copyWith({required String status}) {
    return OrdersModel(
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
