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

  factory ItemsModel.fromJson({
    required Map<String, dynamic> json,
    required List<dynamic> lineItems,
    required String number,
    String? college,
  }) {
    final productsList = <ProductModel>[];
    for (final items in lineItems) {
      final json = items as Map<String, dynamic>;
      final model = ProductModel.fromJson(json: json);
      productsList.add(model);
    }

    if (lineItems.isNotEmpty && college != null) {
      final options = (lineItems[0] ?? {} as Map<String, dynamic>)['options']
          as List<dynamic>;

      // print(number);
      final grad = (options.length > 1)
          ? ((options[1] as Map<String, dynamic>)['selection'] as String)
              .split(' ')
          : [];
      final typeInit =
          ((lineItems[0] as Map<String, dynamic>)['translatedName'] as String)
              .split("-")
              .last
              .trim();
      final typeList = typeInit.split(" ");
      String typeString = '';
      for (int i = 0; i < typeList.length; i++) {
        if (college == 'nui' && i > 2) {
          break;
        }
        typeString = typeString + typeList[i].trim() + " ";
      }
      // print(((lineItems[0] as Map<String, dynamic>)['name'] as String));

      String graduationDate = '';

      if (grad.isNotEmpty) {
        for (final i in grad) {
          graduationDate = graduationDate + i + ' ';
        }
      }

      return ItemsModel(
        quantity: json['quantity'] as int,
        total: double.parse(json['total'].toString()),
        products: productsList,
        number: int.parse(number),
        // type: ((lineItems[0] as Map<String, dynamic>)['translatedName'])
        //     .toString(),
        // // .split('-')
        // // .last,
        type: typeString,
        height: (options[0] as Map<String, dynamic>)['selection'] ?? " ",
        gradDate: graduationDate,
      );
    } else if (lineItems.isEmpty) {
      // final gradDate = (json['gradDate'] as String).split(" ");

      // print(gradDate);

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

  Map<String, dynamic> toMap({required String college}) {
    final list = [];
    for (final i in products) {
      final model = i.toMap();
      list.add(model);
    }

    // final typeInit = type.split("-").last.trim();
    // final typeList = typeInit.split(" ");
    // print(typeList);

    // String typeString = '';
    // print(typeInit);
    // for (int i = 0; i < typeList.length; i++) {
    //   if (college == 'nui' && i > 2) {
    //     break;
    //   }
    //   typeString = typeString + typeList[i].trim() + " ";
    // }

    return {
      "quantity": quantity,
      "total": total,
      "products": list,
      "number": number,
      "gradDate": gradDate,
      // "type":
      //     '${type.trim().split(" ")[3].trim()} ${type.trim().split(" ")[4].trim()} ${type.trim().split(" ")[5].trim()}',
      "type": type,
      "height": height,
      // "json": json,
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
      "price": price,
      "productId": productId,
    };
  }

  final String productId;
  final double price;
}
