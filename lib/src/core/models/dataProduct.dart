import 'package:appjeshua/src/core/models/product.dart';

class DataProduct {
  int currentPage;
  Products products;
  int from;
  int lastPage;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  DataProduct.fromJson(Map<String, dynamic> snapshot) {
    currentPage = snapshot['current_page'];
    products = Products.fromJsonList(snapshot['data']);
  }
}
