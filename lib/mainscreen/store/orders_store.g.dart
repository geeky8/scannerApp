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

  @override
  String toString() {
    return '''
newOrders: ${newOrders},
pendingOrders: ${pendingOrders},
newState: ${newState},
pendingState: ${pendingState},
completedState: ${completedState},
selectedTabIndex: ${selectedTabIndex}
    ''';
  }
}
