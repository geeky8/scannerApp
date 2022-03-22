import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

import 'package:scanner/enums/file_state.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/screens/order_detail_screen.dart';

import 'package:scanner/mainscreen/store/orders/orders_store.dart';
import 'package:scanner/mainscreen/utils/constants.dart';
import 'package:scanner/mainscreen/utils/dialog_boxes/failure_dialogbox.dart';
import 'package:scanner/mainscreen/utils/dialog_boxes/success_dialogbox.dart';
import 'package:scanner/mainscreen/utils/dialog_boxes/user_dialog.dart';
import 'package:scanner/mainscreen/widgets/filter_button.dart';
import 'package:scanner/mainscreen/widgets/generate_qr_button.dart';
import 'package:scanner/mainscreen/widgets/order_details_card.dart';
import 'package:scanner/mainscreen/widgets/orders_checkbox.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final store = context.read<OrdersStore>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: primaryColor,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: primaryColor),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Observer(builder: (_) {
                      final state = store.fileState;

                      switch (state) {
                        case FileState.SELECTED:
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Select Files',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                IconButton(
                                    onPressed: () {
                                      store.fileState = FileState.NORMAL;
                                      store.generateQRList.clear();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 22,
                                    )),
                              ],
                            ),
                          );
                        case FileState.NORMAL:
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Scanner',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                Row(
                                  children: [
                                    const FilterButton(),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        store.fileState = FileState.SELECTED;
                                      },
                                      icon: const Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                      }
                    }),
                    const SizedBox(height: 20),
                    TabBar(
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onTap: (index) {
                          store.selectedTabIndex = index;
                        },
                        tabs: const [
                          Tab(
                            text: 'New',
                          ),
                          Tab(
                            text: 'Pending',
                          ),
                          Tab(
                            text: 'Completed',
                          ),
                        ]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child:
                  TabBarView(physics: const BouncingScrollPhysics(), children: [
                Observer(builder: (_) {
                  // final ordersList = store.newOrders;
                  final state = store.newState;
                  // final _repository = OrdersRepository();
                  switch (state) {
                    case StoreState.LOADING:
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    case StoreState.SUCCESS:
                      return RefreshIndicator(
                        onRefresh: () async {
                          await store.getNewOrders();
                        },
                        color: primaryColor,
                        child: Observer(builder: (_) {
                          final fileState = store.fileState;

                          switch (fileState) {
                            case FileState.SELECTED:
                              return Stack(
                                children: [
                                  // OrdersList(
                                  //   ordersList: ordersList,
                                  //   store: store,
                                  //   fileState: fileState,
                                  // ),
                                  Observer(builder: (_) {
                                    final ordersList = store.newOrders;

                                    return ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: ordersList.length,
                                        itemBuilder: (context, index) {
                                          final model = ordersList[index];
                                          // store.qrKey = GlobalKey();
                                          return GestureDetector(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Provider.value(
                                                            value: store,
                                                            child:
                                                                OrderDetailScreen(
                                                              model: model,
                                                            ),
                                                          )));
                                            },
                                            child: Observer(builder: (_) {
                                              final fileState = store.fileState;

                                              switch (fileState) {
                                                case FileState.SELECTED:
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SelectedDetailsCard(
                                                        model: model,
                                                        store: store),
                                                  );
                                                case FileState.NORMAL:
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: OrderDetailCard(
                                                      model: model,
                                                      store: store,
                                                    ),
                                                  );
                                              }
                                            }),
                                          );
                                        });
                                  }),
                                  Positioned(
                                    bottom: 20,
                                    left: MediaQuery.of(context).size.width / 6,
                                    child: GenrateQRButton(store: store),
                                  ),
                                ],
                              );
                            case FileState.NORMAL:
                              // return OrdersList(
                              //   ordersList: ordersList,
                              //   store: store,
                              //   fileState: fileState,
                              // );
                              return Observer(builder: (_) {
                                final ordersList = store.newOrders;

                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: ordersList.length,
                                    itemBuilder: (context, index) {
                                      final model = ordersList[index];
                                      // store.qrKey = GlobalKey();
                                      return GestureDetector(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Provider.value(
                                                        value: store,
                                                        child:
                                                            OrderDetailScreen(
                                                          model: model,
                                                        ),
                                                      )));
                                        },
                                        child: Observer(builder: (_) {
                                          final fileState = store.fileState;

                                          switch (fileState) {
                                            case FileState.SELECTED:
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SelectedDetailsCard(
                                                    model: model, store: store),
                                              );
                                            case FileState.NORMAL:
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: OrderDetailCard(
                                                  model: model,
                                                  store: store,
                                                ),
                                              );
                                          }
                                        }),
                                      );
                                    });
                              });
                          }
                        }),
                      );
                    case StoreState.ERROR:
                      // return const SizedBox();
                      return Center(
                          child: SizedBox(
                        height: 150,
                        child: Image.asset(
                          'assets/images/empty.png',
                          fit: BoxFit.fill,
                        ),
                      ));
                    case StoreState.EMPTY:
                      return Center(
                          child: SizedBox(
                        height: 150,
                        child: Image.asset(
                          'assets/images/empty.png',
                          fit: BoxFit.fill,
                        ),
                      ));
                  }
                }),
                // const Center(child: Text('Pending')),
                Observer(builder: (_) {
                  final state = store.pendingState;
                  switch (state) {
                    case StoreState.LOADING:
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    case StoreState.SUCCESS:
                      return RefreshIndicator(
                        onRefresh: () async {
                          await store.getPendingOrders();
                        },
                        color: primaryColor,
                        // child: OrdersList(
                        //     ordersList: ordersList,
                        //     fileState: FileState.NORMAL,
                        //     store: store),
                        child: Observer(builder: (_) {
                          final ordersList = store.pendingOrders;

                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: ordersList.length,
                              itemBuilder: (context, index) {
                                final model = ordersList[index];
                                // store.qrKey = GlobalKey();
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Provider.value(
                                                  value: store,
                                                  child: OrderDetailScreen(
                                                    model: model,
                                                  ),
                                                )));
                                  },
                                  child: Observer(builder: (_) {
                                    final fileState = store.fileState;

                                    switch (fileState) {
                                      case FileState.SELECTED:
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SelectedDetailsCard(
                                              model: model, store: store),
                                        );
                                      case FileState.NORMAL:
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: OrderDetailCard(
                                            model: model,
                                            store: store,
                                          ),
                                        );
                                    }
                                  }),
                                );
                              });
                        }),
                      );
                    case StoreState.ERROR:
                      return const SizedBox();
                    case StoreState.EMPTY:
                      return Center(
                          child: SizedBox(
                        height: 150,
                        child: Image.asset(
                          'assets/images/empty.png',
                          fit: BoxFit.fill,
                        ),
                      ));
                  }
                }),
                // const Center(child: Text('Completed')),
                Observer(builder: (_) {
                  // final ordersList = store.completedOrders;

                  final state = store.completedState;
                  switch (state) {
                    case StoreState.LOADING:
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    case StoreState.SUCCESS:
                      return RefreshIndicator(
                        onRefresh: () async {
                          await store.getCompletedOrders();
                        },
                        color: primaryColor,
                        // child: OrdersList(
                        //   fileState: FileState.NORMAL,
                        //   store: store,
                        // ),
                        child: Observer(builder: (_) {
                          final ordersList = store.completedOrders;

                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: ordersList.length,
                              itemBuilder: (context, index) {
                                final model = ordersList[index];
                                // store.qrKey = GlobalKey();
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Provider.value(
                                                  value: store,
                                                  child: OrderDetailScreen(
                                                    model: model,
                                                  ),
                                                )));
                                  },
                                  child: Observer(builder: (_) {
                                    final fileState = store.fileState;

                                    switch (fileState) {
                                      case FileState.SELECTED:
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SelectedDetailsCard(
                                              model: model, store: store),
                                        );
                                      case FileState.NORMAL:
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: OrderDetailCard(
                                            model: model,
                                            store: store,
                                          ),
                                        );
                                    }
                                  }),
                                );
                              });
                        }),
                      );
                    case StoreState.ERROR:
                      return const SizedBox();
                    case StoreState.EMPTY:
                      return Center(
                          child: SizedBox(
                        height: 150,
                        child: Image.asset(
                          'assets/images/empty.png',
                          fit: BoxFit.fill,
                        ),
                      ));
                  }
                }),
              ]),
            ),
          ],
        ),
        floatingActionButton: Observer(builder: (_) {
          final state = store.fileState;

          switch (state) {
            case FileState.SELECTED:
              return const SizedBox();
            case FileState.NORMAL:
              return FloatingActionButton(
                onPressed: () async {
                  final model = await store.qrScanner();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return UserDialog(
                          model: model,
                          store: store,
                        );
                        // return const FailureDialog();
                        // return const SuccessDialog();
                      });
                },
                child: const Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: primaryColor,
              );
          }
        }),
      ),
    );
  }
}

// class UserDialog extends StatelessWidget {
//   const UserDialog({
//     required this.model,
//     Key? key,
//   }) : super(key: key);

//   final OrdersModel model;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height / 1.5,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(13),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircleAvatar(
//                   child: Icon(
//                     Icons.person,
//                     color: Colors.white,
//                     size: 70,
//                   ),
//                   backgroundColor: primaryColor,
//                   radius: 60,
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     children: [
//                       DialogText(
//                         text: '${model.number}',
//                         icon: Icons.format_list_bulleted,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       DialogText(
//                         text: model.userInfo.firstName,
//                         icon: Icons.person,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       DialogText(
//                         text: model.orderStatus,
//                         icon: Icons.label,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DialogText extends StatelessWidget {
//   const DialogText({
//     Key? key,
//     required this.text,
//     required this.icon,
//   }) : super(key: key);

//   final String text;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: primaryColor,
//           size: 25,
//         ),
//         const SizedBox(
//           width: 7,
//         ),
//         Text(text,
//             style: const TextStyle(
//               color: primaryColor,
//               fontWeight: FontWeight.w400,
//               fontSize: 22,
//             )),
//       ],
//     );
//   }
// }

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
    required this.fileState,
    required this.store,
  }) : super(key: key);
  final OrdersStore store;
  final FileState fileState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Observer(builder: (_) {
        final ordersList = store.pendingOrders;

        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: ordersList.length,
            itemBuilder: (context, index) {
              final model = ordersList[index];
              // store.qrKey = GlobalKey();
              return GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Provider.value(
                                value: store,
                                child: OrderDetailScreen(
                                  model: model,
                                ),
                              )));
                },
                child: Observer(builder: (_) {
                  final fileState = store.fileState;

                  switch (fileState) {
                    case FileState.SELECTED:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectedDetailsCard(model: model, store: store),
                      );
                    case FileState.NORMAL:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrderDetailCard(
                          model: model,
                          store: store,
                        ),
                      );
                  }
                }),
              );
            });
      }),
    );
  }
}

class SelectedDetailsCard extends StatelessWidget {
  const SelectedDetailsCard({
    Key? key,
    required this.model,
    required this.store,
  }) : super(key: key);

  final OrdersModel model;
  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CheckBoxOrder(
          model: model,
          store: store,
        ),
        const SizedBox(
          width: 5,
        ),
        OrderDetailCard(
          model: model,
          store: store,
        ),
      ],
    );
  }
}
