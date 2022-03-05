import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/enums/status.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';
import 'package:scanner/mainscreen/utils/constants.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({required this.model, Key? key}) : super(key: key);

  final OrdersModel model;

  @override
  Widget build(BuildContext context) {
    final store = context.read<OrdersStore>();

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  // alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 4,
                      backgroundColor: primaryColor,
                      backgroundImage: const AssetImage(
                        'assets/images/notes.png',
                        // scale: 50,
                        // height: MediaQuery.of(context).size.height / 6,
                        // width: MediaQuery.of(context).size.width / 3,
                        // fit: BoxFit.contain,
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(30),
                      //   child: Image.asset(
                      //     'assets/images/notes.png',
                      //     // scale: 50,
                      //     height: MediaQuery.of(context).size.height / 6,
                      //     width: MediaQuery.of(context).size.width / 3,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextBlock(
                            label: 'Order No.# :',
                            text: model.number.toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextBlock(
                            label: 'Name :',
                            text:
                                '${model.userInfo.firstName} ${model.userInfo.lastName}',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextBlock(
                            label: 'E-mail :',
                            text: model.userInfo.email,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextBlock(
                            label: 'Checkout Price :',
                            text: model.itemsModel.total.toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextBlock(
                            label: 'Quantity :',
                            text: model.itemsModel.quantity.toString(),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          //  TextBlock(
                          //   label: 'Checkout Price :',
                          //   text: model.itemsModel.total.toString(),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 6,
            bottom: 20,
            child: Observer(builder: (_) {
              final state = currStatus(model.orderStatus);

              if (state == Status.NEW) {
                return OrderQrCodeGen(store: store, model: model);
              } else {
                return const SizedBox();
              }
            }),
          ),
        ],
      ),
    );
  }
}

class TextBlock extends StatelessWidget {
  const TextBlock({
    required this.label,
    required this.text,
    Key? key,
  }) : super(key: key);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: primaryColor,
          ),
        )
      ],
    );
  }
}

class OrderQrCodeGen extends StatelessWidget {
  const OrderQrCodeGen({required this.store, required this.model, Key? key})
      : super(key: key);

  final OrdersStore store;
  final OrdersModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await store.generateQRCodeOrder(model: model);
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        padding: const EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 1.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Observer(builder: (_) {
          final state = store.buttonState;

          switch (state) {
            case ButtonState.LOADING:
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            case ButtonState.SUCCESS:
              return const Text(
                'Generate QR code',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              );
          }
        }),
      ),
    );
  }
}
