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
    /*
    final url = Uri.http(api.urlBase, api.urlOrder);

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    final order = Orders.fromJsonList((decodedData['orders'])['data']);
    return order; */
    var data = [
      {
        'id': 1,
        'total': '700',
        'subtotal': '550',
        'status': 'abierto',
        'open': 'si',
        'paid': 'no',
        'create_at': '2020-08-08'
      },
      {
        'id': 1,
        'total': '7000',
        'subtotal': '5500',
        'status': 'cerrado',
        'open': 'no',
        'paid': 'si',
        'create_at': '2020-08-01'
      }
    ];

    return Orders.fromJsonList(data);
  }
}
