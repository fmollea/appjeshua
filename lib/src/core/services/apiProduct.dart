import 'dart:convert';

import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/productDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiProduct {
  Api api = Api();
  User user = User();

  final String _page = 'page';

  Future<Products> getProducts(int page) async {
    var productDto = Products();

    final params = {
      _page: page.toString(),
    };

    final buildPath = '${api.urlProduct}/${user.idSucursal}';
    final url = Uri.https(api.urlBase, buildPath, params);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    if (decodedData['data'] == null) {
      productDto = Products.fromJsonList(null);
    } else {
      productDto = Products.fromJsonList(decodedData['data']);
    }

    return productDto;
  }

  Future<Products> searchProductsByCategory(
      String slugCategory, int page) async {

    var productDto = ProductDto();

    final params = {
      _page: page.toString(),
    };

    final buildPath = '${api.urlProductByCategory}/$slugCategory/${user.idSucursal}';
    final url = Uri.https(api.urlBase, buildPath, params);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    if (decodedData['data'] == null) {
      productDto = ProductDto.fromJson(null);
    } else {
      productDto = ProductDto.fromJson(decodedData['data']);
    }

    return productDto.data.products;
  }

  Future<Products> searchProductsByQueryParam(
      String query, int perpage) async {

    final buildPath = '${api.urlProductSearch}/$query/$perpage/null/${user.idSucursal}';

    final url = Uri.https(api.urlBase, buildPath);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final productDto = Products.fromJsonList(decodedData);

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
