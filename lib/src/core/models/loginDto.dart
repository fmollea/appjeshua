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
      getUserInfo(snapshot['user']);
    }
  }

  getUserInfo(Map<String, dynamic> snapshot) {
    user.name = snapshot['fullname']; 
    user.email = snapshot['email'];
    user.idSucursal = snapshot['sucursal'];
  }
}
