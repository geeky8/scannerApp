// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrdersStore on _OrdersStore, Store {
  final _$newOrdersAtom = Atom(name: '_OrdersStore.newOrders');

  @override
  ObservableList<OrdersModel> get newOrders {
    _$newOrdersAtom.reportRead();
    return super.newOrders;
  }

  @override
  set newOrders(ObservableList<OrdersModel> value) {
    _$newOrdersAtom.reportWrite(value, super.newOrders, () {
      super.newOrders = value;
    });
  }

  final _$pendingOrdersAtom = Atom(name: '_OrdersStore.pendingOrders');

  @override
  ObservableList<OrdersModel> get pendingOrders {
    _$pendingOrdersAtom.reportRead();
    return super.pendingOrders;
  }

  @override
  set pendingOrders(ObservableList<OrdersModel> value) {
    _$pendingOrdersAtom.reportWrite(value, super.pendingOrders, () {
      super.pendingOrders = value;
    });
  }

  final _$completedOrdersAtom = Atom(name: '_OrdersStore.completedOrders');

  @override
  ObservableList<OrdersModel> get completedOrders {
    _$completedOrdersAtom.reportRead();
    return super.completedOrders;
  }

  @override
  set completedOrders(ObservableList<OrdersModel> value) {
    _$completedOrdersAtom.reportWrite(value, super.completedOrders, () {
      super.completedOrders = value;
    });
  }

  final _$newStateAtom = Atom(name: '_OrdersStore.newState');

  @override
  StoreState get newState {
    _$newStateAtom.reportRead();
    return super.newState;
  }

  @override
  set newState(StoreState value) {
    _$newStateAtom.reportWrite(value, super.newState, () {
      super.newState = value;
    });
  }

  final _$pendingStateAtom = Atom(name: '_OrdersStore.pendingState');

  @override
  StoreState get pendingState {
    _$pendingStateAtom.reportRead();
    return super.pendingState;
  }

  @override
  set pendingState(StoreState value) {
    _$pendingStateAtom.reportWrite(value, super.pendingState, () {
      super.pendingState = value;
    });
  }

  final _$completedStateAtom = Atom(name: '_OrdersStore.completedState');

  @override
  StoreState get completedState {
    _$completedStateAtom.reportRead();
    return super.completedState;
  }

  @override
  set completedState(StoreState value) {
    _$completedStateAtom.reportWrite(value, super.completedState, () {
      super.completedState = value;
    });
  }

  final _$fileStateAtom = Atom(name: '_OrdersStore.fileState');

  @override
  FileState get fileState {
    _$fileStateAtom.reportRead();
    return super.fileState;
  }

  @override
  set fileState(FileState value) {
    _$fileStateAtom.reportWrite(value, super.fileState, () {
      super.fileState = value;
    });
  }

  final _$buttonStateAtom = Atom(name: '_OrdersStore.buttonState');

  @override
  ButtonState get buttonState {
    _$buttonStateAtom.reportRead();
    return super.buttonState;
  }

  @override
  set buttonState(ButtonState value) {
    _$buttonStateAtom.reportWrite(value, super.buttonState, () {
      super.buttonState = value;
    });
  }

  final _$generateQRListAtom = Atom(name: '_OrdersStore.generateQRList');

  @override
  ObservableList<OrdersModel> get generateQRList {
    _$generateQRListAtom.reportRead();
    return super.generateQRList;
  }

  @override
  set generateQRList(ObservableList<OrdersModel> value) {
    _$generateQRListAtom.reportWrite(value, super.generateQRList, () {
      super.generateQRList = value;
    });
  }

  final _$selectedTabIndexAtom = Atom(name: '_OrdersStore.selectedTabIndex');

  @override
  int get selectedTabIndex {
    _$selectedTabIndexAtom.reportRead();
    return super.selectedTabIndex;
  }

  @override
  set selectedTabIndex(int value) {
    _$selectedTabIndexAtom.reportWrite(value, super.selectedTabIndex, () {
      super.selectedTabIndex = value;
    });
  }

  final _$selectedCollegeAtom = Atom(name: '_OrdersStore.selectedCollege');

  @override
  String get selectedCollege {
    _$selectedCollegeAtom.reportRead();
    return super.selectedCollege;
  }

  @override
  set selectedCollege(String value) {
    _$selectedCollegeAtom.reportWrite(value, super.selectedCollege, () {
      super.selectedCollege = value;
    });
  }

  final _$isFilterAppliedAtom = Atom(name: '_OrdersStore.isFilterApplied');

  @override
  ButtonState get isFilterApplied {
    _$isFilterAppliedAtom.reportRead();
    return super.isFilterApplied;
  }

  @override
  set isFilterApplied(ButtonState value) {
    _$isFilterAppliedAtom.reportWrite(value, super.isFilterApplied, () {
      super.isFilterApplied = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_OrdersStore.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$getNewOrdersAsyncAction = AsyncAction('_OrdersStore.getNewOrders');

  @override
  Future<void> getNewOrders() {
    return _$getNewOrdersAsyncAction.run(() => super.getNewOrders());
  }

  final _$getPendingOrdersAsyncAction =
      AsyncAction('_OrdersStore.getPendingOrders');

  @override
  Future<void> getPendingOrders() {
    return _$getPendingOrdersAsyncAction.run(() => super.getPendingOrders());
  }

  final _$getCompletedOrdersAsyncAction =
      AsyncAction('_OrdersStore.getCompletedOrders');

  @override
  Future<void> getCompletedOrders() {
    return _$getCompletedOrdersAsyncAction
        .run(() => super.getCompletedOrders());
  }

  final _$addPendingDataAsyncAction =
      AsyncAction('_OrdersStore.addPendingData');

  @override
  Future<void> addPendingData({required OrdersModel model}) {
    return _$addPendingDataAsyncAction
        .run(() => super.addPendingData(model: model));
  }

  final _$addCompletedDataAsyncAction =
      AsyncAction('_OrdersStore.addCompletedData');

  @override
  Future<void> addCompletedData({required OrdersModel model}) {
    return _$addCompletedDataAsyncAction
        .run(() => super.addCompletedData(model: model));
  }

  final _$qrScannerAsyncAction = AsyncAction('_OrdersStore.qrScanner');

  @override
  Future<OrdersModel> qrScanner() {
    return _$qrScannerAsyncAction.run(() => super.qrScanner());
  }

  final _$generateQRCodesAsyncAction =
      AsyncAction('_OrdersStore.generateQRCodes');

  @override
  Future<void> generateQRCodes() {
    return _$generateQRCodesAsyncAction.run(() => super.generateQRCodes());
  }

  final _$generateOrderQRCodeAsyncAction =
      AsyncAction('_OrdersStore.generateOrderQRCode');

  @override
  Future<void> generateOrderQRCode({required OrdersModel model}) {
    return _$generateOrderQRCodeAsyncAction
        .run(() => super.generateOrderQRCode(model: model));
  }

  final _$applyFilterAsyncAction = AsyncAction('_OrdersStore.applyFilter');

  @override
  Future<void> applyFilter({required BuildContext context}) {
    return _$applyFilterAsyncAction
        .run(() => super.applyFilter(context: context));
  }

  final _$removeFilterAsyncAction = AsyncAction('_OrdersStore.removeFilter');

  @override
  Future<void> removeFilter({required BuildContext context}) {
    return _$removeFilterAsyncAction
        .run(() => super.removeFilter(context: context));
  }

  @override
  String toString() {
    return '''
newOrders: ${newOrders},
pendingOrders: ${pendingOrders},
completedOrders: ${completedOrders},
newState: ${newState},
pendingState: ${pendingState},
completedState: ${completedState},
fileState: ${fileState},
buttonState: ${buttonState},
generateQRList: ${generateQRList},
selectedTabIndex: ${selectedTabIndex},
selectedCollege: ${selectedCollege},
isFilterApplied: ${isFilterApplied}
    ''';
  }
}
