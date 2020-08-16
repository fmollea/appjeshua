import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:appjeshua/src/core/models/brandDto.dart';
import 'package:appjeshua/src/core/models/modelDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'api.dart';

class ApiSelectedLift {
  Api api = Api();
  User user = User();
  final _branId = "brand_id";

  Future<Brands> getBrands() async {
    final url = Uri.http(api.urlBase, api.urlBrand);

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final brands = Brands.fromJsonList(decodedData['category']);

    return brands;
  }

  Future<Models> getModels(int brandId) async {
    final url =
        Uri.http(api.urlBase, api.urlModel, {_branId: brandId.toString()});

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final models = Models.fromJsonList(decodedData['category']);

    return models;
  }
}
