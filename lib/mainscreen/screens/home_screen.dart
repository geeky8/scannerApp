import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scanner/enums/status.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:provider/provider.dart';
import 'package:scanner/mainscreen/store/orders_store.dart';

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
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Scanner',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
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
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: ordersList.length,
                                  itemBuilder: (context, index) {
                                    final model = ordersList[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        final pendingModel = model.copyWith(
                                            status: Status.PENDING.inString());
                                        await store.addPendingData(
                                            model: pendingModel);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                        ),
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
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                        ),
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
