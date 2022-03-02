import 'package:flutter/material.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';

class CheckBoxOrder extends StatelessWidget {
  const CheckBoxOrder({required this.model, required this.store, Key? key})
      : super(key: key);

  final OrdersModel model;
  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: model.isCheck,
      onChanged: (check) {
        final list = store.newOrders;
        final index = list.indexWhere((element) => model.id == element.id);
        final checkedModel = model.copyWith(isCheck: check);
        store.newOrders
          ..removeAt(index)
          ..insert(index, checkedModel);
        store.newOrders = list;

        /// To update QR Generation list
        final qrList = store.generateQRList;
        final qrIndex = qrList.indexWhere((element) => model.id == element.id);
        if (qrIndex == -1 && checkedModel.isCheck) {
          qrList.add(checkedModel);
        } else if (qrIndex != -1 && !checkedModel.isCheck) {
          qrList.removeAt(qrIndex);
        }
        store.generateQRList = qrList;
      },
      activeColor: Colors.black,
      checkColor: Colors.white,
    );
  }
}
