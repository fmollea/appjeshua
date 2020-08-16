import 'dart:convert';

import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiRegister {
  Api api = Api();

  final String _name = 'name';
  final String _email = 'email';
  final String _password = 'password';
  final String _confirmPass = 'password_confirmation';

  Future<ResponseDto> postRegister(
      String name, String email, String pass, String confirmPass) async {
    final url = Uri.http(api.urlBase, api.urlRegister, {
      _name: name,
      _email: email,
      _password: pass,
      _confirmPass: confirmPass
    });

    final response = await http.post(url);
    final decodedData = json.decode(response.body);

    final regiterDto = ResponseDto.fromJson(decodedData);

    return regiterDto;
  }
}
