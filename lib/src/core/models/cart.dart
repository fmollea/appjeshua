import 'package:appjeshua/src/core/models/product.dart';

class Cart {
  int id;
  Product product;
  int amount;

  Cart.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    product = Product.fromJson(snapshot['product']);
    setAmount(snapshot['amount']);
  }

  setAmount(String value) {
    double valueDouble = double.parse(value);
    amount = valueDouble.round();
  }

  Cart(this.id, this.product, this.amount);
}

class Carts {
  List<Cart> list = List();

  Carts();

  Carts.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final cart = Cart.fromJson(item);
      list.add(cart);
    });
  }
}
