import 'package:flutter/material.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OrdersModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber),
      child: Row(
        children: [
          Text(model.userInfo.firstName),
          const SizedBox(
            width: 10,
          ),
          Text(model.userInfo.email),
        ],
      ),
    );
  }
}
