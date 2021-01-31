import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/core/models/cart.dart';
import 'package:appjeshua/src/core/models/deliveryAddress.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:intl/intl.dart';

class OrderDto {
  String id;
  String order;
  String total;
  String paid;
  String create;
  String dayExpired;

  OrderDto.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    order = snapshot['order'];
    total = setPrice(snapshot['total']);
    create = snapshot['date'] == null ? _getDateFormat() : snapshot['date'];
    paid = snapshot['pay_status'];
    dayExpired = snapshot['date'];
  }
}

class Orders {
  List<OrderDto> list = List();

  Orders();

  Orders.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final order = OrderDto.fromJson(item);
      list.add(order);
    });
  }

  static fromJsonDetail(List<dynamic> jsonList) {
    final user = User();
    setOrderData(jsonList.firstWhere((item) => item['id'] == user.idOrder));
  }
}

void setOrderData(Map<String, dynamic> snapshot) {
    var user = User();
    user.date = snapshot['date'];
    user.lastOrder = snapshot['id'];
    user.payment = snapshot['pay_method'];
    user.carts = Carts.fromJsonListOrderDetail(snapshot['details']);
  
    user.deliveryAddress = snapshot['shippingAddress'] == null ? DeliveryAddress() : DeliveryAddress.fromJson(snapshot['shippingAddress']);
    user.billingAddress = snapshot['billingAddress'] == null ? BillingAddress() : BillingAddress.fromJson(snapshot['billingAddress']);
}

String setPrice(dynamic price) {
  if(price == null) return '0';

  if (price is int) {
    return price.toString();
  }

  if (price is double) {
    return price.toStringAsFixed(2);
  }

  return '0';
} 

String _getDateFormat() => DateFormat('dd-MM-yyyy')
      .format(DateTime.now());