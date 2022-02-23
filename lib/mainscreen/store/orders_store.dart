import 'package:mobx/mobx.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/repository/orders_repository.dart';

part 'orders_store.g.dart';

class OrdersStore = _OrdersStore with _$OrdersStore;

abstract class _OrdersStore with Store {
  final _repository = OrdersRepository();

  @observable
  ObservableList<OrdersModel> newOrders = ObservableList.of([]);

  @observable
  ObservableList<OrdersModel> pendingOrders = ObservableList.of([]);

  @observable
  StoreState storeState = StoreState.SUCCESS;

  @observable
  int selectedTabIndex = 0;

  @action
  Future<void> init() async {
    try {
      storeState = StoreState.LOADING;
      final newList = await _repository.getNewOrdersList();
      final pendingList = await _repository.getPendingOrdersList();
      if (newList.isNotEmpty) {
        newOrders.addAll(newList);
        pendingOrders.addAll(pendingList);
        storeState = StoreState.SUCCESS;
      } else {
        storeState = StoreState.EMPTY;
      }
    } on Exception catch (_) {
      storeState = StoreState.ERROR;
    }
  }

  Future<void> uploadDummy({required OrdersModel model}) async {
    try {
      _repository.uploadDummyData(model: model);
    } on Exception catch (_) {
      print('Exception');
    }
  }
}
