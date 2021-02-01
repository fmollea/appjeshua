import 'dart:convert';

import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiProduct {
  Api api = Api();
  User user = User();

  final String _page = 'page';

  Future<Products> getProducts(int page) async {
    var products = Products();

    final params = {
      _page: page.toString(),
    };

    if (user.filterUrl == null) user.filterUrl = 'a-z';

    final buildPath = '${api.urlProduct}/${user.idSucursal}/${user.filterUrl}/${user.userId}';
    final url = Uri.https(api.urlBase, buildPath, params);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    if (decodedData['data'] == null) {
      products = Products.fromJsonList(null);
    } else {
      products = Products.fromJsonList(decodedData['data']);
    }

    return products;
  }

  Future<Products> searchProductsByCategory(
      String slugCategory, int page) async {

    var products = Products();

    if (user.filterUrl == null) user.filterUrl = 'a-z';

    final params = {
      _page: page.toString(),
    };

    final buildPath = '${api.urlProductByCategory}/$slugCategory/${user.idSucursal}/${user.userId}/${user.filterUrl}';
    final url = Uri.https(api.urlBase, buildPath, params);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    if (decodedData['data'] == null || (decodedData['data'] as List<dynamic>).isEmpty) {
      products = Products.fromJsonList(null);
    } else {
      products = Products.fromJsonList(decodedData['data']);
    }

    return products;
  }

  Future<Products> searchProductsByQueryParam(
      String query, int perpage, int page) async {

    final params = {
      _page: page.toString(),
    };    

    final buildPath = '${api.urlProductSearch}/$query/${user.userId}/null/$perpage/${user.idSucursal}/a-z';

    final url = Uri.https(api.urlBase, buildPath, params);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final products = Products.fromJsonList(decodedData['data']);

    return products;
  }

  Future<Product> showProduct(String slugProduct) async {
    final buildPath = '${api.urlProductDetail}/$slugProduct/${user.userId}';
    final url = Uri.https(api.urlBase, buildPath);
    final response = await http.get(url);

    final decodedData = json.decode(response.body);
    final product = Product.fromJson(decodedData['items']);

    return product;
  }
}