import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';
import 'package:scanner/mainscreen/utils/constants.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<OrdersStore>();
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Select Filters',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  child: Expanded(
                    child: ListView(
                      children: List.generate(colToCollegeList.length, (index) {
                        // String? val = colToCollegeList[colToCollegeList.keys.w];
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: ListTile(
                              title:
                                  Text(colToCollegeList.values.toList()[index]),
                              leading: Observer(builder: (_) {
                                return Radio(
                                  activeColor: primaryColor,
                                  value:
                                      colToCollegeList.values.toList()[index],
                                  groupValue: store.selectedCollege,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      store.selectedCollege = value;
                                      // print(value);
                                    }
                                  },
                                );
                              })),
                        );
                      }),
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 80,
                // ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 6,
            child: Observer(builder: (_) {
              return FilterButton(store: store);
            }),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: Observer(builder: (_) {
              final state = store.isFilterApplied;

              switch (state) {
                case ButtonState.LOADING:
                  return const CircularProgressIndicator(
                    color: primaryColor,
                  );
                case ButtonState.SUCCESS:
                  return const SizedBox();
                case ButtonState.APPLIED:
                  return RemoveFilterButton(
                    store: store,
                    contextParent: context,
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.store,
  }) : super(key: key);

  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await store.applyFilter(context: context);
        // store.isFilterApplied = ButtonState.APPLIED;
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
                'Apply Filter',
                style: TextStyle(
                    fontSize: 20,
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

class RemoveFilterButton extends StatelessWidget {
  const RemoveFilterButton({
    Key? key,
    required this.store,
    required this.contextParent,
  }) : super(key: key);

  final OrdersStore store;
  final BuildContext contextParent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        store.removeFilter(context: contextParent);
      },
      child: CircleAvatar(
        // padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        backgroundColor: primaryColor,
        radius: 15,
        child: Observer(builder: (_) {
          final state = store.isFilterApplied;

          switch (state) {
            case ButtonState.LOADING:
              return const CircularProgressIndicator(
                color: primaryColor,
              );
            case ButtonState.SUCCESS:
              return const SizedBox();
            case ButtonState.APPLIED:
              return const Icon(
                Icons.remove,
                size: 15,
                color: Colors.white,
              );
          }
        }),
      ),
    );
  }
}
