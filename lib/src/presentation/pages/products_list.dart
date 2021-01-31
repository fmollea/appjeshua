import 'package:appjeshua/src/commons/search_delegate.dart';
import 'package:appjeshua/src/presentation/widget/content_list_product.dart';
import 'package:flutter/material.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  Map<String, String> _params;
  
  String title = "Listado de productos";
  String filter = "none";

  @override
  Widget build(BuildContext context) {
    _params = ModalRoute.of(context).settings.arguments;

    if (_params != null && _params.containsKey('title')) {
        title = _params['title'];
    }

    if (_params != null && _params.containsKey('category')) {
        filter = _params['category'];
    }

    return Scaffold(
      appBar: AppBar(title: Text(title),
        actions: [
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search, color: Colors.white),
              ),
              onTap: () {
                showSearch(context: context, delegate: DataSearch(filter));
              },
            ),  
        ]),
      body: Stack(children: <Widget>[ContentListProduct(params: _params)]),
    );
  }
}