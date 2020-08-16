import 'dart:convert';

import 'package:appjeshua/src/core/models/loginDto.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiLogin {
  Api api = Api();

  final String _email = 'email';
  final String _password = 'password';

  Future<LoginDto> postLogin(String email, String pass) async {
    // TODO quitar este comment
    /*
    final url =
        Uri.http(api.urlBase, api.urlLogin, {_email: email, _password: pass});

    final response = await http.post(url);
    final decodedData = json.decode(response.body);

    final loginDto = LoginDto.fromJson(decodedData);
    */

    var decodedData = {
      'status': 'ok',
      'code': 200,
      'message': 'ok',
      'data': {'token': '111'}
    };

    final loginDto = LoginDto.fromJson(decodedData);

    return loginDto;
  }
}
