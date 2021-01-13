import 'package:appjeshua/src/core/models/cart.dart';

class User {
  User._private();

  static final User _instance = User._private();

  factory User() {
    return _instance;
  }

  String token;
  int userId;
  String name;
  String email;
  String image;
  int idSucursal;
  int deliveryId;
  int paymentId;
  String payment;
  int billingId;
  List<Cart> carts;
  int cantCarts;
  String lastOrder;
  String date;
  String idOrder;
  String tokenFcm;
  String filterUrl;

  String obtainTotal() {
    var _totalAmount = 0.0;
    carts.forEach((element) {
      _totalAmount =
          _totalAmount + element.quantity * double.parse(element.product.price);
    });

    return _totalAmount.toStringAsFixed(2);
  }

  int cantProducts() => carts.toList().length;
}