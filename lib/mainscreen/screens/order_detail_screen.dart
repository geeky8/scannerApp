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
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
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
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: const Image(
                                  image: AssetImage(
                                    'assets/images/notes.png',
                                    // scale: 50,
                                    // height: MediaQuery.of(context).size.height / 6,
                                    // width: MediaQuery.of(context).size.width / 3,
                                    // fit: BoxFit.contain,
                                  ),
                                ),
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
                                    text: model.itemsModel.number.toString(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBlock(
                                    label: 'Mobile :',
                                    text: model.userInfo.phone,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBlock(
                                    label: 'Address:',
                                    text: model.addressModel.addressLine,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBlock(
                                    label: 'City:',
                                    text: model.addressModel.city,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBlock(
                                    label: 'Postal Code:',
                                    text: model.addressModel.postalCode,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBlock(
                                    label: 'Gown Type:',
                                    text: model.itemsModel.type,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBlock(
                                    label: 'Height:',
                                    text: model.itemsModel.height ?? 'ft',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (model.userInfo.buyerNote == null)
                                    TextBlock(
                                      label: 'Graduation Date:',
                                      text: model.itemsModel.gradDate ??
                                          '00-00-0000',
                                    ),
                                  if (model.userInfo.buyerNote != null)
                                    TextBlock(
                                      label: 'Buyer Note:',
                                      text: model.userInfo.buyerNote!,
                                    ),

                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // TextBlock(
                                  //   label: 'College :',
                                  //   text: model.collegeName,
                                  // ),
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
                // return ModButton(store: store, buttonText: 'Generate QR Code', func: ()async{
                //   await store.
                // })
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
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: primaryColor,
            ),
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
        await store.generateOrderQRCode(model: model);
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
              return const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            case ButtonState.SUCCESS:
              return const Text(
                'Generate QR code',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              );
            case ButtonState.APPLIED:
              return const SizedBox();
          }
        }),
      ),
    );
  }
}
