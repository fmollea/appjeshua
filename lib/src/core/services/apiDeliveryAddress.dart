
import 'dart:convert';
import 'dart:io';

import 'package:appjeshua/src/core/models/deliveryAddress.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiDeliveryAddress {

  Api api = Api();
  User user = User();

  final String _id = 'id';
  final String _name = 'name';
  final String _days = 'days';
  final String _address = 'address';
  final String _city = 'city';
  final String _postalCode = 'postal_code';
  final String _stateId = 'state_id';

  Future<ResponseDto> addDeliveryAddress(String name, String days, String address, String city, String postalCode,
      String stateId) async {

    final url = Uri.http(api.urlBase, api.urlAddDeliveryAddress, {
      _name         : name,
      _days         : days,
      _address      : address,
      _city         : city,
      _postalCode   : postalCode,
      _stateId      : stateId,
    });

    final response = await http.post(url, headers: {HttpHeaders.authorizationHeader: user.token},);
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }

  Future<ResponseDto> updateDeliveryAddress(int id, String name, String days, String address, String city, String postalCode,
      String stateId) async {

    final url = Uri.http(api.urlBase, api.urlUpdateDeliveryAddress, {
      _id           : id.toString(),
      _name         : name,
      _days         : days,
      _address      : address,
      _city         : city,
      _postalCode   : postalCode,
      _stateId      : stateId,
    });

    final response = await http.post(url, headers: {HttpHeaders.authorizationHeader: user.token},);
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }

  Future<DeliveryAddress> showDeliveryAddress(int id) async {
    final path = api.urlDeliveryAddress +'/'+ id.toString() +'/show';
    final url = Uri.http(api.urlBase, path);
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final deliveryAddress = DeliveryAddress.fromJson(decodedData['deliveryAddres']);

    return deliveryAddress;
  }

  Future<DeliveryAddresses> listDeliveryAddress() async {
    final path = api.urlDeliveryAddress;
    final url = Uri.http(api.urlBase, path);
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final jsondata = decodedData['deliveryaddress'];
    DeliveryAddresses listAddress;
    if (jsondata.toString() == '[]') {
      listAddress = DeliveryAddresses.fromJsonList(jsondata);
    } else {
      listAddress = DeliveryAddresses.fromJsonList(jsondata['data']);
    }

    return listAddress;
  }

  Future<ResponseDto> removeDeliveryAddress(int id) async {
    final path = api.urlDeliveryAddress +'/'+ id.toString() +'/remove';
    final url = Uri.http(api.urlBase, path);
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }

  Future<ResponseDto> defaultDeliveryAddress(int id) async {
    final path = api.urlDeliveryAddress +'/'+ id.toString() +'/default';
    final url = Uri.http(api.urlBase, path);
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: user.token},);
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }
}