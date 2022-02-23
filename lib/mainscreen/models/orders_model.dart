import 'package:scanner/enums/fulfillment_status.dart';
import 'package:scanner/mainscreen/models/address_model.dart';
import 'package:scanner/mainscreen/models/items_model.dart';

class OrdersModel {
  OrdersModel({
    required this.fname,
    required this.createdAt,
    required this.email,
    required this.lname,
    required this.id,
    required this.contact,
    required this.addressModel,
    required this.itemsModel,
    required this.fulFillmentStatus,
  });

  factory OrdersModel.fromJson({required Map<String, dynamic> json}) {
    final billingInfo = json['billingInfo'] as Map<String, dynamic>;
    final addressModel = AddressModel.fromJson(address: billingInfo['address']);
    final itemsModel =
        ItemsModel.fromJson(json: json['totals'], lineItems: json['lineItems']);
    return OrdersModel(
      fname: billingInfo['firstName'] as String,
      createdAt: json['_dateCreated'] as String,
      email: billingInfo['email'] as String,
      lname: billingInfo['lastName'] as String,
      id: json['_id'] as String,
      contact: billingInfo['phone'] as String,
      addressModel: addressModel,
      itemsModel: itemsModel,
      fulFillmentStatus: json['fulfillmentStatus'] as String,
    );
  }

  final String fname;
  final String lname;
  final String contact;
  final String id;
  final ItemsModel itemsModel;
  final AddressModel addressModel;
  final String createdAt;
  final String email;
  final String fulFillmentStatus;
}
