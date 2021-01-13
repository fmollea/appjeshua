import 'dart:convert';

import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiFavourite {
  Api api = Api();
  User user = User();

  Future<Products> getProductsFavourites(int page, int perpage) async {

    final buildPath = '${api.urlGetFavourite}/${user.idSucursal}/${user.userId}';
    final url = Uri.https(api.urlBase, buildPath);
    final response = await http.get(url);

    final decodedData = json.decode(response.body);
    final productDto = Products.fromJsonList(decodedData);

    return productDto;
  }

  Future<ResponseDto> addProducFavourite(int id) async {
    final url =
        Uri.https(api.urlBase, api.urlUpdateFavourite, {"user_id": user.userId.toString(),"product_id": id.toString()});

    final response = await http.post(url);
 
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }

  Future<ResponseDto> removeProducFavourite(int id) async {
    final url =
        Uri.https(api.urlBase, api.urlUpdateFavourite, {"user_id": user.userId.toString(),"product_id": id.toString()});

    final response = await http.post(url);
 
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }
}