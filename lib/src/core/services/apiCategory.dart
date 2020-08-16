import 'dart:convert';

import 'package:appjeshua/src/core/models/category.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiCategory {
  Api api = Api();

  Future<Categories> getCategories() async {
    /*
    final url = Uri.http(api.urlBase, api.urlCategory);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final categories = Categories.fromJsonList(decodedData['category']);

    return categories; */

    var data = [
      {
        'id': 1,
        'name': 'Antibioticos',
        'status': '1',
        'image': 'cat_antibioticos',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Bebe',
        'status': '1',
        'image': 'cat_babys',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Peso',
        'status': '1',
        'image': 'cat_ctlpeso',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Diabéticos',
        'status': '1',
        'image': 'cat_diabeticos',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Médicos',
        'status': '1',
        'image': 'cat_dispmedic',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Higiene Per',
        'status': '1',
        'image': 'cat_higuieneper',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Cosméticos',
        'status': '1',
        'image': 'cat_mcosmeticos',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Medicamentos',
        'status': '1',
        'image': 'cat_medicamentos',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Nuevos',
        'status': '1',
        'image': 'cat_nuevos',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Promociones',
        'status': '1',
        'image': 'cat_promociones',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Rehidratantes',
        'status': '1',
        'image': 'cat_rehidratantes',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      },
      {
        'id': 1,
        'name': 'Salud Sexual',
        'status': '1',
        'image': 'cat_vidasexual',
        'created_at': '1974-03-20',
        'updated_at': '1974-03-20'
      }
    ];

    return Categories.fromJsonList(data);
  }
}
