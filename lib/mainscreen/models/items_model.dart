class ItemsModel {
  ItemsModel({
    required this.quantity,
    required this.subTotal,
    required this.total,
    required this.taxPrice,
    required this.productModelList,
  });

  factory ItemsModel.fromJson(
      {required Map<String, dynamic> json, required List<dynamic> lineItems}) {
    final productsList = <ProductModel>[];
    for (final items in lineItems) {
      final json = items as Map<String, dynamic>;
      final model = ProductModel.fromJson(json: json);
      productsList.add(model);
    }

    return ItemsModel(
      quantity: json['quantity'] as int,
      subTotal: json['subtotal'] as double,
      total: double.parse(json['total'].toString()),
      taxPrice: json['tax'] as double,
      productModelList: productsList,
    );
  }

  Map<String, dynamic> toMap() {
    final list = <Map<String, dynamic>>[];
    for (final i in productModelList) {
      final model = i.toMap();
      list.add(model);
    }

    return {
      "quantity": quantity,
      "subTotal": subTotal,
      "total": total,
      "taxPrice": taxPrice,
      "productModelList": list,
    };
  }

  // "totals": {
  //           "discount": 0,
  //           "quantity": 3,
  //           "shipping": 0,
  //           "subtotal": 92.98,
  //           "tax": 19.52,
  //           "total": 112.5,
  //           "weight": 0
  //       },

  final int quantity;
  final double subTotal;
  final double total;
  final double taxPrice;
  final List<ProductModel> productModelList;
}

class ProductModel {
  ProductModel({
    required this.collegeName,
    required this.productId,
    required this.imageUrl,
    required this.price,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    final image = json['mediaItem'] as Map<String, dynamic>;
    return ProductModel(
      collegeName: json['name'] as String,
      productId: json['productId'],
      imageUrl: image['src'] as String,
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "collegeName": collegeName,
      "productId": productId,
      "imageUrl": imageUrl,
      "price": price,
    };
  }

  final String collegeName;
  final String productId;
  final double price;
  final String imageUrl;
}
