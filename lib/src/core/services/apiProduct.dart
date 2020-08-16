import 'dart:convert';
import 'dart:io';

import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/productDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiProduct {
  Api api = Api();
  User user = User();

  final String _queryParam = 'queryparam';
  final String _page = 'page';
  final String _perpage = 'perpage';
  final String _categoriaId = 'categoria_id';
  final String _brandId = "brand_id";
  final String _model = "model";
  final String _serie = "serie";

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
      'precio_pub': '72.10',
      'cantidad': '12',
      'is_fav': true,
      'is_avaiable': false
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
      'precio_pub': '64.10',
      'cantidad': '4',
      'is_fav': true,
      'is_avaiable': true
    },
    {
      'id': 3,
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
      'precio_pub': '64.10',
      'cantidad': '4',
      'is_fav': true,
      'is_avaiable': true
    },
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
      'precio_pub': '72.10',
      'cantidad': '12',
      'is_fav': false,
      'is_avaiable': false
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
      'precio_pub': '64.10',
      'cantidad': '4',
      'is_fav': true,
      'is_avaiable': true
    }
  ];

  Future<Products> getProducts() async {
    /* TODO quitar
    final url = Uri.http(api.urlBase, api.urlProduct);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final productDto = ProductDto.fromJson(decodedData);

    return productDto; */

    final productDto = Products.fromJsonList(data);

    return productDto;
  }

  Future<Products> searchProductsByCategory(
      String category, int page, int perpage) async {
    /*
    final params = {
      _categoriaId: category,
      _page: page.toString(),
      _perpage: perpage.toString()
    };

    final url = Uri.http(api.urlBase, api.urlProductlist, params);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final productDto = ProductDto.fromJson(decodedData);

    return productDto.data.products;
    */
    final productDto = Products.fromJsonList(data);

    return productDto;
  }

  Future<Products> searchProductsByQueryParam(
      String query, int page, int perpage) async {
    /*
    final params = {
      _queryParam: query,
      _page: page.toString(),
      _perpage: perpage.toString()
    };

    final url = Uri.http(api.urlBase, api.urlProductlist, params);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final productDto = ProductDto.fromJson(decodedData);

    return productDto.data.products; */

    final productDto = Products.fromJsonList(data);

    return productDto;
  }

  Future<Products> searchProductsBySelectedLift(
      String brandId, String model, String serie, int page, int perpage) async {
    /*
    final params = {
      _brandId: brandId,
      _model: model,
      _serie: serie,
      _page: page.toString(),
      _perpage: perpage.toString()
    };

    final url = Uri.http(api.urlBase, api.urlProductlist, params);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final productDto = ProductDto.fromJson(decodedData);

    return productDto.data.products; */

    final productDto = Products.fromJsonList(data);

    return productDto;
  }

  Future<Product> showProduct(int id) async {
    /*
    final path = api.urlProduct + '/' + id.toString() + '/show';
    final url = Uri.http(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final product = Product.fromJson(decodedData['product']);
    */
    final productDto = Products.fromJsonList(data);
    return productDto.list[0];
  }
}
