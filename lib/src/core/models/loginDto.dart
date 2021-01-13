import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/core/models/deliveryAddress.dart';
import 'package:appjeshua/src/core/models/user.dart';

class LoginDto {
  int code;
  final user = User();

  LoginDto(this.code);

  LoginDto.fromJson(Map<String, dynamic> snapshot) {

    if (snapshot == null || snapshot['access_token'] == null) {
      code = 400;
    } else {
      code = 200;
      user.token = snapshot['access_token'];
      user.filterUrl = 'a-z';
      getUserInfo(snapshot['user']);
    }
  }

  getUserInfo(Map<String, dynamic> snapshot) {
    user.name = snapshot['fullname']; 
    user.email = snapshot['email'];
    user.idSucursal = snapshot['sucursal'];
    user.userId = snapshot['id'];

    var shipping = DeliveryAddress();
    var billing = BillingAddress(); 

    user.deliveryId = snapshot['shippingAddress']['id'];
    shipping.street = snapshot['shippingAddress']['address'];
    shipping.inside = snapshot['shippingAddress']['nro_int'];
    shipping.outside = snapshot['shippingAddress']['nro_ext'];
    shipping.colony = snapshot['shippingAddress']['colony'];
    shipping.city = snapshot['shippingAddress']['city'];
    shipping.postal = snapshot['shippingAddress']['postal'];

    user.billingId = snapshot['billingAddress']['id']; 
    billing.rfc = snapshot['billingAddress']['rfc'];
    billing.street = snapshot['billingAddress']['address'];
    billing.inside = snapshot['billingAddress']['nro_int'];
    billing.outside = snapshot['billingAddress']['nro_ext'];
    billing.colony = snapshot['billingAddress']['colony'];
    billing.city = snapshot['billingAddress']['city'];
    billing.postal = snapshot['billingAddress']['postal'];
  }
}