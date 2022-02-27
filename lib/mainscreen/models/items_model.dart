class ItemsModel {
  ItemsModel({
    required this.quantity,
    required this.subTotal,
    required this.total,
    required this.taxPrice,
    required this.products,
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
      products: productsList,
    );
  }

  Map<String, dynamic> toMap() {
    // final list = <Map<String, dynamic>>[];
    // for (final i in products) {
    //   final model = i.toMap();
    //   list.add(model);
    // }

    // print(list.toString());

    return {
      "quantity": quantity,
      "subTotal": subTotal,
      "total": total,
      "taxPrice": taxPrice,
      "products": products.map((e) => e.toMap())
        ..toList()
        ..toString(),
    };
  }

  final int quantity;
  final double subTotal;
  final double total;
  final double taxPrice;
  final List<ProductModel> products;
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
