class ItemsModel {
  ItemsModel({
    required this.quantity,
    required this.total,
    required this.products,
    required this.number,
    this.gradDate,
    this.height,
    required this.type,
  });

  factory ItemsModel.fromJson(
      {required Map<String, dynamic> json,
      required List<dynamic> lineItems,
      required String number}) {
    final productsList = <ProductModel>[];
    for (final items in lineItems) {
      final json = items as Map<String, dynamic>;
      final model = ProductModel.fromJson(json: json);
      productsList.add(model);
    }

    if (lineItems.isNotEmpty) {
      final options = (lineItems[0] ?? {} as Map<String, dynamic>)['options']
          as List<dynamic>;
      return ItemsModel(
        quantity: json['quantity'] as int,
        total: double.parse(json['total'].toString()),
        products: productsList,
        number: int.parse(number),
        type: ((lineItems[0] as Map<String, dynamic>)['name'] as String)
            .split('-')
            .last,
        height: (options[0] as Map<String, dynamic>)['selection'] ?? " ",
        gradDate: (options.length > 1)
            ? (options[1] as Map<String, dynamic>)['selection']
            : " ",
      );
    } else if (lineItems.isEmpty) {
      return ItemsModel(
        quantity: json['quantity'] as int,
        total: double.parse(json['total'].toString()),
        products: productsList,
        number: int.parse(number),
        type: json['type'] as String,
        height: json['height'] as String,
        gradDate: json['gradDate'] as String,
      );
    } else {
      return ItemsModel(
        quantity: json['quantity'] as int,
        total: double.parse(json['total'].toString()),
        products: productsList,
        number: int.parse(number),
        type: ((lineItems[0] as Map<String, dynamic>)['name'] as String)
            .split('-')
            .first,
      );
    }
    // print((options[1] as Map<String, dynamic>)['selection']);

    // return ItemsModel(
    //   quantity: int.parse((json['quantity'] as int).toString() ?? json['quantity'].toString()),
    //   subTotal: double.parse(json['subtotal'].toString()),
    //   total: double.parse(json['total'].toString()),
    //   taxPrice: double.parse(json['tax'].toString()),
    //   products: productsList,
    // );
  }

  Map<String, dynamic> toMap() {
    final list = [];
    for (final i in products) {
      final model = i.toMap();
      list.add(model);
    }
    return {
      "quantity": quantity,
      "total": total,
      "products": list,
      "number": number,
      "gradDate": gradDate,
      "height": height,
      "type": type,
    };
  }

  final int quantity;
  final double total;
  final List<ProductModel> products;
  final int number;
  final String? height;
  final String? gradDate;
  final String type;
}

class ProductModel {
  ProductModel({
    required this.productId,
    required this.price,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      productId: json['productId'] as String,
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "price": price,
    };
  }

  final String productId;
  final double price;
}
