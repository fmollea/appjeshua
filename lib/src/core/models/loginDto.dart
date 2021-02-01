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
    user.sucursalName = snapshot['sucursal_name'];
    user.userId = snapshot['id'];
    user.image = snapshot['image'];
    user.deliveryId = snapshot['shippingAddress']['id'];
    user.billingId = snapshot['billingAddress']['id'];
  }
}