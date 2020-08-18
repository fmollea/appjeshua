import 'dart:convert';
import 'dart:io';

import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiBillingAddress {
  Api api = Api();
  User user = User();

  final String _id = 'id';
  final String _rfc = 'rfc';
  final String _businessName = 'business_name';
  final String _type = 'type';
  final String _address = 'address';
  final String _city = 'city';
  final String _postalCode = 'postal_code';
  final String _outside = 'outside';
  final String _inside = 'inside';
  final String _stateId = 'state_id';

  Future<ResponseDto> addBillingAddress(
      String rfc,
      String businessName,
      String type,
      String address,
      String city,
      String postalCode,
      String outside,
      String inside,
      String stateId) async {
    /*
    final url = Uri.http(api.urlBase, api.urlAddBillingAddress, {
      _rfc: rfc,
      _businessName: businessName,
      _type: type,
      _address: address,
      _city: city,
      _postalCode: postalCode,
      _outside: outside,
      _inside: inside,
      _stateId: stateId
    });

    final response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: user.token},
    );
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
    */
  }

  Future<ResponseDto> updateBillingAddress(
      int id,
      String rfc,
      String businessName,
      String type,
      String address,
      String city,
      String postalCode,
      String outside,
      String inside,
      String stateId) async {
    /*
    final url = Uri.http(api.urlBase, api.urlUpdateBillingAddress, {
      _id: id.toString(),
      _rfc: rfc,
      _businessName: businessName,
      _type: type,
      _address: address,
      _city: city,
      _postalCode: postalCode,
      _outside: outside,
      _inside: inside,
      _stateId: stateId
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

  Future<BillingAddress> showBillingAddress(int id) async {
    /*
    final path = api.urlBillingAddress + '/' + id.toString() + '/show';
    final url = Uri.http(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final deliveryAddress =
        BillingAddress.fromJson(decodedData['deliveryAddres']);

    return deliveryAddress; */
    var data = {
      'id': 1,
      'rfc': '5800',
      'business_name': 'Mi dirección',
      'type': 'type',
      'address': 'Calle falsa 123',
      'city': 'Ciudad de México',
      'postal_code': '5800',
      'outside': 'no',
      'inside': 'no',
      'isDefault': '1',
      'state_id': '1',
      'customer_id': '1'
    };

    return BillingAddress.fromJson(data);
  }

  Future<BillingAddresses> listBillingAddress() async {
    /*
    final path = api.urlBillingAddress;
    final url = Uri.http(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final jsonList = decodedData['billingaddress'];
    BillingAddresses listAddress;
    if (jsonList.toString() == '[]') {
      listAddress = BillingAddresses.fromJsonList(jsonList);
    } else {
      listAddress = BillingAddresses.fromJsonList(jsonList['data']);
    }

    return listAddress;
    */
    var data = [
      {
        'id': 1,
        'rfc': '5800',
        'business_name': 'Mi dirección',
        'type': 'type',
        'address': 'Calle falsa 123',
        'city': 'México',
        'postal_code': '5800',
        'outside': 'no',
        'inside': 'no',
        'default': '1',
        'state_id': '1',
        'customer_id': '1'
      },
      {
        'id': 2,
        'rfc': '3655',
        'business_name': 'Mi dirección 2',
        'type': 'type',
        'address': 'Calle falsa 456',
        'city': 'México',
        'postal_code': '1234',
        'outside': 'no',
        'inside': 'no',
        'default': '0',
        'state_id': '1',
        'customer_id': '1'
      },
      {
        'id': 1,
        'rfc': '5800',
        'business_name': 'Mi dirección 3',
        'type': 'type',
        'address': 'Calle larga 888',
        'city': 'Puebla',
        'postal_code': '9878',
        'outside': 'no',
        'inside': 'no',
        'default': '0',
        'state_id': '1',
        'customer_id': '1'
      }
    ];

    return BillingAddresses.fromJsonList(data);
  }

  Future<ResponseDto> removeBillingAddress(int id) async {
    /*
    final path = api.urlBillingAddress + '/' + id.toString() + '/remove';
    final url = Uri.http(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
    */
  }

  Future<ResponseDto> defaultBillingAddress(int id) async {
    /*
    final path = api.urlBillingAddress + '/' + id.toString() + '/default';
    final url = Uri.http(api.urlBase, path);
    final response = await http.get(
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
}
