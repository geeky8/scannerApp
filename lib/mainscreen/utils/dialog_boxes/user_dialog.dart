import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/enums/status.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';
import 'package:scanner/mainscreen/utils/constants.dart';
import 'package:scanner/mainscreen/utils/dialog_boxes/success_dialogbox.dart';

class UserDialog extends StatelessWidget {
  const UserDialog({
    required this.model,
    required this.store,
    Key? key,
  }) : super(key: key);

  final OrdersModel model;
  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const CircleAvatar(
                //   child: Icon(
                //     Icons.person,
                //     color: Colors.white,
                //     size: 70,
                //   ),
                //   backgroundColor: primaryColor,
                //   radius: 60,
                // ),
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    'assets/images/notes.png',
                    fit: BoxFit.cover,
                  ),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      DialogText(
                        text: '${model.itemsModel.number}',
                        label: 'Order No.# :',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DialogText(
                        text: model.userInfo.firstName,
                        label: 'Name :',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DialogText(
                        text: model.orderStatus,
                        label: 'Status :',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                StateButton(
                  model: model,
                  store: store,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StateButton extends StatelessWidget {
  const StateButton({
    required this.model,
    required this.store,
    Key? key,
  }) : super(key: key);

  final OrdersModel model;
  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final state = currStatus(model.orderStatus);
        switch (state) {
          case Status.NEW:
            await store.addPendingData(model: model);
            await store.getPendingOrders();
            Navigator.pop(context);
            break;
          case Status.PENDING:
            await store.addCompletedData(model: model);
            await store.getCompletedOrders();
            Navigator.pop(context);
            break;
          case Status.COMPLETED:
            Navigator.pop(context);
            break;
        }
        showDialog(
            context: context,
            builder: (context) {
              // return UserDialog(
              //   model: model,
              //   store: store,
              // );
              return const SuccessDialog();
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Observer(builder: (_) {
          final state = currStatus(model.orderStatus);
          switch (state) {
            case Status.NEW:
              return MoveButtonText(
                text: 'Pending',
                store: store,
              );
            case Status.PENDING:
              return MoveButtonText(
                text: 'Completed',
                store: store,
              );
            case Status.COMPLETED:
              return MoveButtonText(
                text: 'Cancel',
                store: store,
              );
          }
        }),
      ),
    );
  }
}

class MoveButtonText extends StatelessWidget {
  const MoveButtonText({
    required this.text,
    required this.store,
    Key? key,
  }) : super(key: key);

  final String text;
  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final state = store.buttonState;

      switch (state) {
        case ButtonState.LOADING:
          return const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          );
        case ButtonState.SUCCESS:
          return Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
          );
        case ButtonState.APPLIED:
          return const SizedBox();
      }
    });
  }
}

class DialogText extends StatelessWidget {
  const DialogText({
    Key? key,
    required this.text,
    required this.label,
  }) : super(key: key);

  final String text;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
              color: primaryColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          width: 7,
        ),
        Text(text,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            )),
      ],
    );
  }
}
