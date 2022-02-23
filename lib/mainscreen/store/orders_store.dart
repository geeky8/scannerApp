import 'package:mobx/mobx.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/repository/orders_repository.dart';

part 'orders_store.g.dart';

class OrdersStore = _OrdersStore with _$OrdersStore;

abstract class _OrdersStore with Store {
  final _ordersRepository = OrdersRepository();

  @observable
  ObservableList<OrdersModel> newOrders = ObservableList.of([]);

  @observable
  StoreState storeState = StoreState.SUCCESS;

  @observable
  int selectedTabIndex = 0;

  @action
  Future<void> getNewOrders() async {
    try {
      storeState = StoreState.LOADING;
      final list = await _ordersRepository.getNewOrdersList();
      if (list.isNotEmpty) {
        newOrders.addAll(list);
        storeState = StoreState.SUCCESS;
      } else {
        storeState = StoreState.EMPTY;
      }
    } on Exception catch (_) {
      storeState = StoreState.ERROR;
    }
  }
}
