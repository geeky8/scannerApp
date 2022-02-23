import 'package:scanner/enums/status.dart';
import 'package:scanner/mainscreen/models/address_model.dart';
import 'package:scanner/mainscreen/models/items_model.dart';

class OrdersModel {
  OrdersModel({
    required this.firstName,
    required this.createdAt,
    required this.email,
    required this.lastName,
    required this.id,
    required this.contact,
    required this.addressModel,
    required this.itemsModel,
    required this.orderStatus,
  });

  factory OrdersModel.fromJson({required Map<String, dynamic> json}) {
    final billingInfo = json['billingInfo'] as Map<String, dynamic>;
    final addressModel = AddressModel.fromJson(address: billingInfo['address']);
    final itemsModel =
        ItemsModel.fromJson(json: json['totals'], lineItems: json['lineItems']);
    return OrdersModel(
      firstName: billingInfo['firstName'] as String,
      createdAt: json['_dateCreated'] as String,
      email: billingInfo['email'] as String,
      lastName: billingInfo['lastName'] as String,
      id: json['_id'] as String,
      contact: billingInfo['phone'] as String,
      addressModel: addressModel,
      itemsModel: itemsModel,
      orderStatus: json['status'] ?? Status.NEW.inString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "_dateCreated": createdAt,
      "email": email,
      "lastName": lastName,
      "_id": id,
      "phone": contact,
      "address": addressModel.toMap(),
      "items": itemsModel.toMap(),
      "orderStatus": orderStatus,
    };
  }

  OrdersModel copyWith({required String status}) {
    return OrdersModel(
      firstName: firstName,
      createdAt: createdAt,
      email: email,
      lastName: lastName,
      id: id,
      contact: contact,
      addressModel: addressModel,
      itemsModel: itemsModel,
      orderStatus: (orderStatus == 'new') ? status : orderStatus,
    );
  }

  final String firstName;
  final String lastName;
  final String contact;
  final String id;
  final ItemsModel itemsModel;
  final AddressModel addressModel;
  final String createdAt;
  final String email;
  final String orderStatus;
}
