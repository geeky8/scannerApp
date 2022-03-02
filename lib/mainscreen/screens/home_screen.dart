import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';
import 'package:scanner/enums/file_state.dart';
import 'package:scanner/enums/status.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/screens/widgets/order_details.dart';
import 'package:scanner/mainscreen/screens/widgets/orders_checkbox.dart';

import 'package:scanner/mainscreen/store/orders/orders_store.dart';

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
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Colors.black,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.black),
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
                                IconButton(
                                  onPressed: () {
                                    store.fileState = FileState.SELECTED;
                                  },
                                  icon: const Icon(
                                    Icons.picture_as_pdf,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                )
                              ],
                            ),
                          );
                      }
                    }),
                    const SizedBox(height: 20),
                    Observer(builder: (_) {
                      return TabBar(
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
                          ]);
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Observer(builder: (_) {
                return TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Observer(builder: (_) {
                        final ordersList = store.newOrders;
                        final state = store.newState;
                        // final _repository = OrdersRepository();
                        switch (state) {
                          case StoreState.LOADING:
                            return const Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          case StoreState.SUCCESS:
                            return RefreshIndicator(
                              onRefresh: () async {
                                await store.getNewOrders();
                              },
                              color: Colors.black,
                              child: Observer(builder: (_) {
                                final fileState = store.fileState;

                                switch (fileState) {
                                  case FileState.SELECTED:
                                    return Stack(
                                      children: [
                                        OrdersList(
                                          ordersList: ordersList,
                                          store: store,
                                          fileState: fileState,
                                        ),
                                        Positioned(
                                            bottom: 20,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5,
                                            child: const GenrateQRButton()),
                                      ],
                                    );
                                  case FileState.NORMAL:
                                    return OrdersList(
                                      ordersList: ordersList,
                                      store: store,
                                      fileState: fileState,
                                    );
                                }
                              }),
                            );
                          case StoreState.ERROR:
                            return const SizedBox();
                          case StoreState.EMPTY:
                            return const Center(
                                child: SizedBox(
                              height: 50,
                              child: Text(
                                "Nothing's Here",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                            ));
                        }
                      }),
                      // const Center(child: Text('Pending')),
                      Observer(builder: (_) {
                        final ordersList = store.pendingOrders;

                        final state = store.pendingState;
                        switch (state) {
                          case StoreState.LOADING:
                            return const Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          case StoreState.SUCCESS:
                            return RefreshIndicator(
                              onRefresh: () async {
                                await store.getPendingOrders();
                              },
                              color: Colors.black,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: ordersList.length,
                                  itemBuilder: (context, index) {
                                    final model = ordersList[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        final pendingModel = model.copyWith(
                                            status:
                                                Status.COMPLETED.inString());
                                        await store.addCompletedData(
                                            model: pendingModel);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: OrderDetail(model: model),
                                        // Container(
                                        //   padding: const EdgeInsets.all(10),
                                        //   decoration: BoxDecoration(
                                        //       shape: BoxShape.rectangle,
                                        //       borderRadius:
                                        //           BorderRadius.circular(10),
                                        //       color: Colors.amber),
                                        //   child: Row(
                                        //     children: [
                                        //       Text(model.userInfo.firstName),
                                        //       const SizedBox(
                                        //         width: 10,
                                        //       ),
                                        //       Text(model.userInfo.email),
                                        //     ],
                                        //   ),
                                        // ),
                                      ),
                                    );
                                  }),
                            );
                          case StoreState.ERROR:
                            return const SizedBox();
                          case StoreState.EMPTY:
                            return const Center(
                                child: SizedBox(
                              height: 50,
                              child: Text(
                                "Nothing's Here",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                            ));
                        }
                      }),
                      const Center(child: Text('Completed')),
                    ]);
              }),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: Colors.black,
        //     onPressed: () async {
        //       final repo = OrdersRepository();
        //       await repo.getNewOrdersList();
        //     },
        //     child: const Icon(
        //       Icons.add_circle_outline_sharp,
        //       color: Colors.white,
        //     )),
      ),
    );
  }
}

class GenrateQRButton extends StatelessWidget {
  const GenrateQRButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(12)),
        child: const Text(
          'Generate QR codes',
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
    required this.ordersList,
    required this.fileState,
    required this.store,
  }) : super(key: key);

  final List<OrdersModel> ordersList;
  final OrdersStore store;
  final FileState fileState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          final model = ordersList[index];
          // store.qrKey = GlobalKey();
          return GestureDetector(
            // onTap: () async {
            //   // showModalBottomSheet(
            //   //     context: context,
            //   //     shape: RoundedRectangleBorder(
            //   //       borderRadius:
            //   //           BorderRadius.circular(10),
            //   //     ),
            //   //     builder: (context) {
            //   //       return QRCodeWidget(
            //   //         model: model,
            //   //         store: store,
            //   //       );
            //   //     });
            //   // final pendingModel = model.copyWith(
            //   //     status: Status.PENDING.inString());
            //   // await store.addPendingData(
            //   //     model: pendingModel);
            // },
            child: Observer(builder: (_) {
              final fileState = store.fileState;

              switch (fileState) {
                case FileState.SELECTED:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectedOrderDetails(model: model, store: store),
                  );
                case FileState.NORMAL:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrderDetail(model: model),
                  );
              }
            }),
          );
        });
  }
}

class SelectedOrderDetails extends StatelessWidget {
  const SelectedOrderDetails({
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
        OrderDetail(model: model),
      ],
    );
  }
}
