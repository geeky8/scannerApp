import 'package:mobx/mobx.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/enums/file_state.dart';
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
  StoreState newState = StoreState.SUCCESS;

  @observable
  StoreState pendingState = StoreState.SUCCESS;

  @observable
  StoreState completedState = StoreState.SUCCESS;

  @observable
  FileState fileState = FileState.NORMAL;

  @observable
  ButtonState buttonState = ButtonState.SUCCESS;

  @observable
  ObservableList<OrdersModel> generateQRList = ObservableList.of([]);

  @observable
  int selectedTabIndex = 0;

  @action
  Future<void> init() async {
    await getNewOrders();
    await getPendingOrders();
  }

  @action
  Future<void> getNewOrders() async {
    try {
      newState = StoreState.LOADING;
      final newList = await _repository.getNewOrdersList();
      // final pendingList = await _repository.getPendingOrdersList();
      if (newList.isNotEmpty) {
        newOrders.addAll(newList);
        // pendingOrders.addAll(pendingList);
        newState = StoreState.SUCCESS;
      } else {
        newState = StoreState.EMPTY;
      }
    } on Exception catch (_) {
      newState = StoreState.ERROR;
    }
  }

  @action
  Future<void> getPendingOrders() async {
    try {
      pendingState = StoreState.LOADING;
      // final newList = await _repository.getNewOrdersList();
      final pendingList = await _repository.getPendingOrdersList();
      if (pendingList.isNotEmpty) {
        pendingOrders.addAll(pendingList);
        // pendingOrders.addAll(pendingList);
        pendingState = StoreState.SUCCESS;
      } else {
        pendingState = StoreState.EMPTY;
      }
    } on Exception catch (_) {
      pendingState = StoreState.ERROR;
    }
  }

  Future<void> addPendingData({required OrdersModel model}) async {
    try {
      await _repository.addPendingData(model: model);
      final index = newOrders.indexWhere((element) => element.id == model.id);
      newOrders.removeAt(index);
      pendingOrders.insert(0, model);
    } on Exception catch (_) {
      print('Exception');
    }
  }

  Future<void> addCompletedData({required OrdersModel model}) async {
    try {
      _repository.addCompletedData(model: model);
    } on Exception catch (_) {
      print('Exception');
    }
  }

  // @action
  // void shareQrCode({})
}
