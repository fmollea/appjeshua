import 'package:appjeshua/src/core/models/product.dart';

class Cart {

  int id;
  Product product;
  int quantity;

  Cart.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    product = Product.fromJson(snapshot['product']);
    quantity = snapshot['quantity'];
  }

  Cart.fromJsonOrderDetail(Map<String, dynamic> snapshot) {
    product = Product.fromJsonOrderDetail(snapshot);
    quantity = snapshot['quantity'];
  }

  setAmount(String value) {
    double valueDouble = double.parse(value);
    quantity = valueDouble.round();
  }

  Map<String, dynamic> toJson() => {
      "cartItem": {
        "product": product.toJson(),
        "quantity": quantity,
      },
  };
}

class Carts {
  
  List<Cart> list = List();

  Carts.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      if (item['product'] != null) {
        final cart = Cart.fromJson(item);
      list.add(cart);
      }
    });
  } 

  static List<Cart> fromJsonListOrderDetail(List<dynamic> jsonList) {
    List<Cart> list = List();
    if (jsonList == null) return [];

    jsonList.forEach((item) {
      final cart = Cart.fromJsonOrderDetail(item);
      list.add(cart);
    });

    return list;
  } 

  Carts();
}