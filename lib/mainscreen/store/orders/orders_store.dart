import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobx/mobx.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/enums/file_state.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:scanner/mainscreen/models/orders_model.dart';
import 'package:scanner/mainscreen/repository/orders_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

import 'package:flutter/services.dart';
import 'package:scanner/mainscreen/utils/constants.dart';

part 'orders_store.g.dart';

class OrdersStore = _OrdersStore with _$OrdersStore;

abstract class _OrdersStore with Store {
  final _repository = OrdersRepository();

  @observable
  ObservableList<OrdersModel> newOrders = ObservableList.of([]);

  @observable
  ObservableList<OrdersModel> pendingOrders = ObservableList.of([]);

  @observable
  ObservableList<OrdersModel> completedOrders = ObservableList.of([]);

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

  @observable
  String selectedCollege = colToCollegeList.values.first;

  @observable
  ButtonState isFilterApplied = ButtonState.SUCCESS;

  @action
  Future<void> init() async {
    await getNewOrders();
    await getPendingOrders();
    await getCompletedOrders();
  }

  @action
  Future<void> getNewOrders() async {
    try {
      newState = StoreState.LOADING;
      final newList = await _repository.getNewOrdersList();
      // final pendingList = await _repository.getPendingOrdersList();
      if (newList.isNotEmpty) {
        newOrders
          ..clear()
          ..addAll(newList);
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
        pendingOrders
          ..clear()
          ..addAll(pendingList);
        // pendingOrders.addAll(pendingList);
        pendingState = StoreState.SUCCESS;
      } else {
        pendingState = StoreState.EMPTY;
      }
    } on Exception catch (_) {
      pendingState = StoreState.ERROR;
    }
  }

  @action
  Future<void> getCompletedOrders() async {
    try {
      completedState = StoreState.LOADING;
      // final newList = await _repository.getNewOrdersList();
      final completedList = await _repository.getCompletedOrdersList();
      if (completedList.isNotEmpty) {
        completedOrders
          ..clear()
          ..addAll(completedList);
        // pendingOrders.addAll(pendingList);
        completedState = StoreState.SUCCESS;
      } else {
        completedState = StoreState.EMPTY;
      }
    } on Exception catch (_) {
      completedState = StoreState.ERROR;
    }
  }

  @action
  Future<void> addPendingData({required OrdersModel model}) async {
    try {
      buttonState = ButtonState.LOADING;
      final initModel = model.copyWith(status: 'pending');
      await _repository.moveData(model: initModel);
      buttonState = ButtonState.SUCCESS;
      // final index = newOrders.indexWhere((element) => element.id == model.id);
      // newOrders.removeAt(index);
      // pendingOrders.insert(0, model);
    } on Exception catch (_) {
      // print('Exception');
    }
  }

  @action
  Future<void> addCompletedData({required OrdersModel model}) async {
    try {
      buttonState = ButtonState.LOADING;
      final initModel = model.copyWith(status: 'completed');
      await _repository.moveData(model: initModel);
      buttonState = ButtonState.SUCCESS;
      // final index =
      //     pendingOrders.indexWhere((element) => element.id == model.id);
      // pendingOrders.removeAt(index);
      // completedOrders.insert(0, model);
    } on Exception catch (_) {
      // print('Exception');
    }
  }

  @action
  Future<OrdersModel> qrScanner() async {
    final id = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Back', true, ScanMode.QR);
    final model = await _repository.getUserDetail(id: id);
    if (model == null) {
      final index = newOrders.indexWhere((element) => element.id == id);
      final initModel = newOrders[index];
      return initModel;
    } else {
      return model;
    }
    // final output = await FlutterBarcodeScanner.scanBarcode(
    //     '#ff6666', 'Back', true, ScanMode.QR);
    // return output;
  }

  @action
  Future<void> generateQRCodes() async {
    pw.Document pdf = pw.Document();
    // final list = List.unmodifiable(['1', '2', '3', '4', '5']);
    final list = generateQRList;

    buttonState = ButtonState.LOADING;

    List<ByteData> imageData = [];

    final start = list[0].itemsModel.number;
    final end = list.last.itemsModel.number;

    for (final model in list) {
      final image = await _repository.toImage(data: model.id);
      imageData.add(image!);
      await _repository.moveData(model: model);
    }
    pdf = _repository.createPDF(imageData: imageData);
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: '($start-$end).pdf');
    // .then((value) => print("Done"));

    buttonState = ButtonState.SUCCESS;
  }

  @action
  Future<void> generateOrderQRCode({required OrdersModel model}) async {
    pw.Document pdf = pw.Document();

    buttonState = ButtonState.LOADING;
    final img = await _repository.toImage(data: model.id);

    final image = pw.MemoryImage(
        img!.buffer.asUint8List(img.offsetInBytes, img.lengthInBytes));
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context contex) {
          return pw.Center(child: pw.Image(image));
        }));
    // final file = await _repository.fileConverter(pdf: pdf);
    await _repository.moveData(model: model);
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename:
          '${model.itemsModel.number}(${model.userInfo.firstName}${model.userInfo.lastName}).pdf',
    );
    // .then((value) => print("Done"));
    buttonState = ButtonState.SUCCESS;
  }

  @action
  Future<void> applyFilter({required BuildContext context}) async {
    final query = collegeToColList[selectedCollege];

    buttonState = ButtonState.LOADING;
    if (query != null) {
      newState = StoreState.LOADING;
      await getNewOrders();
      final filteredNewOrders = <OrdersModel>[];
      for (final model in newOrders) {
        if (model.collegeName == selectedCollege) {
          filteredNewOrders.add(model);
        }
      }
      newOrders
        ..clear()
        ..addAll(filteredNewOrders);
      newState = StoreState.SUCCESS;

      final _pendingList =
          await _repository.getFilteredOrders(query: query, status: 'pending');
      newState = StoreState.SUCCESS;
      // print(pendingOrders.length);
      pendingState = StoreState.LOADING;
      // print(_pendingList.length);
      pendingOrders
        ..clear()
        ..addAll(_pendingList);
      // print(pendingOrders.length);

      pendingState = StoreState.SUCCESS;

      completedState = StoreState.LOADING;
      final _completedList = await _repository.getFilteredOrders(
          query: query, status: 'completed');
      // print(completedOrders.length);

      // print(_completedList.length);
      completedOrders
        ..clear()
        ..addAll(_completedList);
      // print(completedOrders.length);

      completedState = StoreState.SUCCESS;
    }
    buttonState = ButtonState.SUCCESS;

    isFilterApplied = ButtonState.APPLIED;

    Navigator.pop(context);
  }

  @action
  Future<void> removeFilter({required BuildContext context}) async {
    isFilterApplied = ButtonState.LOADING;
    await init();
    isFilterApplied = ButtonState.SUCCESS;
    Navigator.pop(context);
  }

  // @action
  // void shareQrCode({})
}
