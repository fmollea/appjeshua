import 'package:appjeshua/src/presentation/widget/content_list_product.dart';
import 'package:flutter/material.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  Map<String, String> _params;

  @override
  Widget build(BuildContext context) {
    _params = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Listado de productos')),
      body: Stack(children: <Widget>[ContentListProduct(params: _params)]),
    );
  }
}