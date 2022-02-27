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

    // return ItemsModel(
    //   quantity: int.parse((json['quantity'] as int).toString() ?? json['quantity'].toString()),
    //   subTotal: double.parse(json['subtotal'].toString()),
    //   total: double.parse(json['total'].toString()),
    //   taxPrice: double.parse(json['tax'].toString()),
    //   products: productsList,
    // );
    return ItemsModel(
      quantity: json['quantity'] as int,
      subTotal: json['subtotal'] as double,
      total: double.parse(json['total'].toString()),
      taxPrice: json['tax'] as double,
      products: productsList,
    );
  }

  Map<String, dynamic> toMap() {
    final list = [];
    for (final i in products) {
      final model = i.toMap();
      list.add(model);
    }
    return {
      "quantity": quantity,
      "subtotal": subTotal,
      "total": total,
      "tax": taxPrice,
      "products": list,
      // "quantity": jsonEncode(quantity),
      // "subtotal": jsonEncode(subTotal),
      // "total": jsonEncode(total),
      // "tax": jsonEncode(taxPrice),
      // "products": jsonEncode([...products]),
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
    required this.price,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      collegeName: json['name'] as String,
      productId: json['productId'] as String,
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "collegeName": collegeName,
      "productId": productId,
      "price": price,
    };
  }

  final String collegeName;
  final String productId;
  final double price;
}
