import 'dart:convert';
import 'dart:io';

import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiFavourite {
  Api api = Api();
  User user = User();

  final _productId = "id";
  final String _page = 'page';
  final String _perpage = 'perpage';
  final String _favourite = "favorite";

  Future<Products> getProductsFavourites(int page, int perpage) async {
    //TODO quitar comentarios
    /* final url = Uri.http(api.urlBase, api.urlProductlist, {
      _page: page.toString(),
      _perpage: perpage.toString(),
      _favourite: "true"
    });

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final productDto = Products.fromJsonList((decodedData['products'])['data']);

    return productDto;
    */

    var data = [
      {
        'id': 1,
        'name': 'Tribedoce Compuesto',
        'code': '123',
        'brand_id': '1',
        'description':
            'Sustancia activa, Complejo B, Diclofenaco 75Mgbr...(descr, de prueba)',
        'path':
            'https://assets2.farmaciasanpablo.com.mx/uploads-prod/productimages/Fsp800Wx800H_44280025_1dt38rjba',
        'precio': '45.75',
        'cantidad': '12',
        'is_fav': true
      },
      {
        'id': 2,
        'name': 'Brupacil Compuesto',
        'code': '456',
        'brand_id': '2',
        'description':
            'Sustancia activa, Complejo B, Diclofenaco 75Mgbr...(descr, de prueba)',
        'path':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQRe7cD6X1nOk3Z45WIm03YFvconPSi7hCSHQ&usqp=CAU',
        'precio': '38.10',
        'cantidad': '4',
        'is_fav': true,
        'is_avaiable': true
      }
    ];

    final productDto = Products.fromJsonList(data);

    return productDto;
  }

  Future<ResponseDto> addProducFavourite(int id) async {
    /* TODO quitar comentairo
    final url =
        Uri.http(api.urlBase, api.urlAddFavourite, {_productId: id.toString()});

    final response = await http
        .post(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto; */

    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }

  Future<ResponseDto> removeProducFavourite(int id) async {
    /* TODO quitar comentarios
    final path = api.urlFavourite + '/' + id.toString() + '/remove';
    final url = Uri.http(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;

    */
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }
}
