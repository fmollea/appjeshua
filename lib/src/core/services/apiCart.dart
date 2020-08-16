import 'dart:convert';
import 'dart:io';

import 'package:appjeshua/src/core/models/cart.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiCart {
  Api api = Api();
  User user = User();

  final _amount = "amount";
  final _productId = "product_id";

  var response = {'status': 'ok', 'code': 200, 'message': 'ok'};

  var data = [
    {
      'id': 1,
      'product': {
        'id': 1,
        'name': 'Tribedoce Compuesto',
        'code': '123',
        'brand_id': '1',
        'description':
            'Sustancia activa, Complejo B, Diclofenaco 75Mgbr...(descr, de prueba)',
        'path':
            'https://assets2.farmaciasanpablo.com.mx/uploads-prod/productimages/Fsp800Wx800H_44280025_1dt38rjba',
        'precio': '45.75',
        'precio_pub': '72.10',
        'cantidad': '12',
        'is_fav': false,
        'is_avaiable': false
      },
      'amount': '2'
    },
    {
      'id': 2,
      'product': {
        'id': 2,
        'name': 'Brupacil Compuesto',
        'code': '456',
        'brand_id': '2',
        'description':
            'Sustancia activa, Complejo B, Diclofenaco 75Mgbr...(descr, de prueba)',
        'path':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQRe7cD6X1nOk3Z45WIm03YFvconPSi7hCSHQ&usqp=CAU',
        'precio': '38.10',
        'precio_pub': '64.10',
        'cantidad': '4',
        'is_fav': true,
        'is_avaiable': true
      },
      'amount': '3'
    },
  ];

  Future<ResponseDto> addProductCart(int amount, int id) async {
    /*
    final url = Uri.http(api.urlBase, api.urlAddCart,
        {_amount: amount.toString(), _productId: id.toString()});

    final response = await http
        .post(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto; */

    final responseDto = ResponseDto.fromJson(response);

    return responseDto;
  }

  Future<Carts> getProductsCart() async {
    /*
    final url = Uri.http(api.urlBase, api.urlGetProductCart);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);

    final responseDto = Carts.fromJsonList(decodedData['cars']);
    return responseDto;
    */

    final responseDto = Carts.fromJsonList(data);
    return responseDto;
  }

  Future<ResponseDto> removeProducCart(int id) async {
    /*
    final path = api.urlCart + '/' + id.toString() + '/remove';
    final url = Uri.http(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
    */
    final responseDto = ResponseDto.fromJson(response);

    return responseDto;
  }
}
