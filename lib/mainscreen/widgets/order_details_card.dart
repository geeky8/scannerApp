import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scanner/enums/file_state.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';
import 'package:scanner/mainscreen/utils/constants.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({
    Key? key,
    required this.model,
    required this.store,
  }) : super(key: key);

  final OrdersModel model;
  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Text(model.userInfo.firstName),

          Observer(builder: (_) {
            final state = store.fileState;

            switch (state) {
              case FileState.SELECTED:
                return const SizedBox();
              case FileState.NORMAL:
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/notes.png',
                    height: 70,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                );
            }
          }),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardText(text: model.itemsModel.number.toString(), label: '#'),
                const SizedBox(
                  height: 4,
                ),
                CardText(text: model.userInfo.firstName, label: 'Name'),
                const SizedBox(
                  height: 4,
                ),
                CardText(
                    text: (model.createdAt.substring(0, 10)), label: 'Date'),
                const SizedBox(
                  height: 4,
                ),
                CardText(text: model.collegeName, label: 'College'),
              ],
            ),
          ),
          // const SizedBox(
          //   width: 15,
          // ),
          // Text(model.userInfo.email),
        ],
      ),
    );
  }
}

class CardText extends StatelessWidget {
  const CardText({
    Key? key,
    required this.text,
    required this.label,
  }) : super(key: key);

  final String text;
  // final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label :',
          style: const TextStyle(
            fontSize: 15,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Text(text,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w300,
              fontSize: 15,
            )),
      ],
    );
  }
}
