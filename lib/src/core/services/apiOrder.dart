import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:appjeshua/src/core/models/OrderDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';

class ApiOrder {
  Api api = Api();
  User user = User();

  Future<Orders> getOrders() async {
    final buildPath = '${api.urlOrder}/${user.userId}';
    final url = Uri.https(api.urlBase, buildPath);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final order = Orders.fromJsonList(decodedData);
    return order; 
  }

  Future<bool> getDetail() async {
    final buildPath = '${api.urlOrder}/${user.userId}';
    final url = Uri.https(api.urlBase, buildPath);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    Orders.fromJsonDetail(decodedData);
    return true; 
  }
}
