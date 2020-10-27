import 'dart:convert';

import 'package:appjeshua/src/core/models/category.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiCategory {
  Api api = Api();

  Future<Categories> getCategories() async {
    final url = Uri.https(api.urlBase, api.urlCategory);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final categories = Categories.fromJsonList(decodedData);

    return categories; 
  }
}
