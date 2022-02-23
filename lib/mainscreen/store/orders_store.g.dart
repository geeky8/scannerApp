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

  final _$storeStateAtom = Atom(name: '_OrdersStore.storeState');

  @override
  StoreState get storeState {
    _$storeStateAtom.reportRead();
    return super.storeState;
  }

  @override
  set storeState(StoreState value) {
    _$storeStateAtom.reportWrite(value, super.storeState, () {
      super.storeState = value;
    });
  }

  final _$getNewOrdersAsyncAction = AsyncAction('_OrdersStore.getNewOrders');

  @override
  Future<void> getNewOrders() {
    return _$getNewOrdersAsyncAction.run(() => super.getNewOrders());
  }

  @override
  String toString() {
    return '''
newOrders: ${newOrders},
storeState: ${storeState}
    ''';
  }
}
