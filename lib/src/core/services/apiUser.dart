import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';

class ApiUser {
  Api api = Api();
  User user = User();

  final String _name = 'name';
  final String _email = 'email';
  final String _oldPass = 'old_password';
  final String _newPass = 'new_password';
  final String _confirmNewPass = 'new_password_confirmation';

  Future<ResponseDto> postUpdateUser(String name, String email, String oldPass,
      String newPass, String confirmNewPass) async {
    /*
    final url = Uri.http(api.urlBase, api.urlEditProfile, {
      _name: name,
      _email: email,
      _oldPass: oldPass,
      _newPass: newPass,
      _confirmNewPass: confirmNewPass
    });

    final response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: user.token},
    );
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
    */
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }

  getUserInfo() async {
    final url = Uri.http(api.urlBase, api.urlGetDateProfile);

    final response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: user.token},
    );
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    if (NetworkUtils.isReqSuccess(responseDto.code)) {
      user.getInfoUser(decodedData['user']);
    }
  }

  Future<ResponseDto> forgetPassword(String email) async {
    // TODO eliminar comentarios y poner api correcta
    /*
    final url = Uri.http(api.urlBase, api.urlForgetPass, {_email: email});

    final response = await http.post(url);
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);
    */
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }
}
