import 'package:appjeshua/src/presentation/widget/content_list_product.dart';
import 'package:flutter/material.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  Map<String, String> _params;
  
  String title = "Listado de productos";

  @override
  Widget build(BuildContext context) {
    _params = ModalRoute.of(context).settings.arguments;

    if (_params != null && _params.containsKey('title')) {
        title = _params['title'];
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Stack(children: <Widget>[ContentListProduct(params: _params)]),
    );
  }
}