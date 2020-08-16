import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/core/models/user.dart';

class LoginDto {
  String status;
  int code;
  String message;

  LoginDto(this.status, this.code, this.message);

  LoginDto.fromJson(Map<String, dynamic> snapshot) {
    status = snapshot['status'];
    code = snapshot['code'];
    message = snapshot['message'];
    if (NetworkUtils.isReqSuccess(code)) getAccesToken(snapshot['data']);
  }

  getAccesToken(Map<String, dynamic> snapshot) {
    final user = User();
    user.token = snapshot['token'];
  }
}
