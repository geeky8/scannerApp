import 'dart:convert';

import 'package:scanner/enums/status.dart';
import 'package:scanner/mainscreen/models/address_model.dart';
import 'package:scanner/mainscreen/models/items_model.dart';
import 'package:scanner/mainscreen/models/user_info_model.dart';
import 'package:scanner/mainscreen/utils/constants.dart';
import 'package:collection/collection.dart';

class OrdersModel {
  OrdersModel({
    required this.createdAt,
    required this.id,
    required this.userInfo,
    required this.addressModel,
    required this.itemsModel,
    required this.orderStatus,
    // required this.number,
    required this.collegeName,
    required this.isCheck,
  });

  factory OrdersModel.fromJson({required Map<String, dynamic> json}) {
    UserInfoModel userInfo;
    AddressModel addressModel;
    ItemsModel itemsModel;
    String colName;

    // Map<String, dynamic> billingInfo = {};
    if (json['status'] == null) {
      final billingInfo = json['billingInfo'] as Map<String, dynamic>;
      final tempName = ((json['lineItems'] as List<dynamic>)[0]
          as Map<String, dynamic>)['name'] as String;

      // print(tempName.contains('TU Dublin'));

      final name = collegeToColList.keys
          .firstWhereOrNull((element) => tempName.contains(element));
      // print("$name, ${json['number'].toString()}");
      // final name = collegeToColList.keys.map((e) => tempName.contains(e));
      colName = name ?? " ";

      userInfo = UserInfoModel.fromMap(
        json: billingInfo,
        buyerNote:
            (json['buyerNote'] != null) ? json['buyerNote'] as String : null,
      );
      addressModel = AddressModel.fromJson(address: billingInfo['address']);
      itemsModel = ItemsModel.fromJson(
        json: json['totals'],
        lineItems: json['lineItems'],
        number: json['number'].toString(),
        college: collegeToColList[name],
      );
    } else {
      final tempName = json['collegeName'] as String;
      final name = colToCollegeList[tempName];
      colName = name ?? " ";

      userInfo = UserInfoModel.fromMap(
        json: jsonDecode(json['userInfo'] as String) as Map<String, dynamic>,
        buyerNote: ((jsonDecode(json['userInfo'] as String)
                    as Map<String, dynamic>)['buyerNote'] !=
                null)
            ? (jsonDecode(json['userInfo'] as String)
                as Map<String, dynamic>)['buyerNote'] as String
            : null,
      );
      addressModel = AddressModel.fromJson(
          address:
              jsonDecode(json['address'] as String) as Map<String, dynamic>);
      itemsModel = ItemsModel.fromJson(
        json: jsonDecode(json['items'] as String) as Map<String, dynamic>,
        lineItems: [],
        number: (jsonDecode(json['items'] as String)
                as Map<String, dynamic>)['number']
            .toString(),
      );
    }

    return OrdersModel(
      createdAt: json['_dateCreated'] as String,
      id: json['_id'] as String,
      userInfo: userInfo,
      // number: int.parse(json['number'].toString()),
      addressModel: addressModel,
      itemsModel: itemsModel,
      orderStatus: json['status'] ?? Status.NEW.inString(),
      isCheck: false,
      collegeName: colName,
    );
  }

  // Map<String, dynamic> toMap() {
  //   // print(itemsModel.toMap()..toString());

  //   return {
  //     "_dateCreated": createdAt,
  //     "_id": id,
  //     "address": jsonEncode(addressModel.toMap()),
  //     "items": jsonEncode(itemsModel.toMap(college: )),
  //     "orderStatus": orderStatus,
  //   };
  // }

  OrdersModel copyWith({String? status, bool? isCheck}) {
    return OrdersModel(
      userInfo: userInfo,
      id: id,
      createdAt: createdAt,
      addressModel: addressModel,
      itemsModel: itemsModel,
      // number: number,
      collegeName: collegeName,
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
  // final int number;
  final String collegeName;
  final bool isCheck;
}
