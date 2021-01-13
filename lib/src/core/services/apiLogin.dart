import 'dart:convert';

import 'package:appjeshua/src/core/models/loginDto.dart';
import 'package:appjeshua/src/core/models/profileData.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogin {
  Api api = Api();

  final String _email = 'email';
  final String _password = 'password';

  Future<LoginDto> postLogin(String email, String pass) async {
    final url =
        Uri.https (api.urlBase, api.urlLogin, {_email: email, _password: pass});    

    try {
      final response = await http.post(url);
      final decodedData = json.decode(response.body);
      final loginDto = LoginDto.fromJson(decodedData);

      return loginDto;
    } catch (e) {
      final loginDto = LoginDto.fromJson(null);

      return loginDto;
    }
  }

  Future<ProfileData> getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('name') ?? "";
    String pass = prefs.getString('password') ?? "";

    final url =
        Uri.https (api.urlBase, api.urlLogin, {_email: email, _password: pass});    

    final response = await http.post(url);
    final decodedData = json.decode(response.body);
    final profileData = ProfileData.fromJson(decodedData['user']);

    return profileData;
  }

  Future<bool> editProfileData(int id, String fullname, String email, String phone, String city,
        String colony, String state, String postal, String country, String movil, String web ,String password) async {


    var params = {
      'city': city,
      'colony': colony,
      'country': country,
      _email: email, 
      'movil': movil,
      _password: password,
      'phone': phone,
      'postal': postal,
      'state': state,
      'web': web
    };
    var body = json.encode(params);

    final url = Uri.https (api.urlBase, api.urlEditProfile + '/' + id.toString());    

    final response = await http.put(url,
    headers: {"Content-Type": "application/json; charset=utf-8"},
     body: body );
    final decodedData = json.decode(response.body);

    return true;
  }
}
