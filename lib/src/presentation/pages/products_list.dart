import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/list_product_widget.dart';
import 'package:flutter/material.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  ScrollController _scrollController = ScrollController();
  Utils utils = Utils();
  Map<String, String> _params;
  final _perpage = 10;
  bool _isLoading = false;
  int _page = 0;
  List<Product> _list = List();
  ApiProduct api = ApiProduct();

  @override
  void initState() {
    super.initState();
    _initScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _params = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Listado de productos')),
      body: Stack(children: <Widget>[_drawList(), _drawLoading()]),
    );
  }

  _drawList() {
    if (_list == null || _list.isEmpty) {
      _fetchData();
      return Center(child: CircularProgressIndicator());
    } else {
      return ListProductWidget(
        products: _list,
        scrollController: _scrollController,
      );
    }
  }

  _fetchData() async {
    _page++;
    Products response;

    if (_params.containsKey('queryparam')) {
      final query = _params['queryparam'];
      response = await api.searchProductsByQueryParam(query, _page, _perpage);
    }

    if (_params.containsKey('categoria_id')) {
      final category = _params['categoria_id'];
      response = await api.searchProductsByCategory(category, _page, _perpage);
    }

    if (_params.containsKey('brand_id')) {
      final brandId = _params['brand_id'];
      final model = _params['model'];
      final serie = _params['serie'];
      response = await api.searchProductsBySelectedLift(
          brandId, model, serie, _page, _perpage);
    }

    _list = _list + response.list.reversed.toList();
    _drawList();
    _isLoading = false;
    setState(() {});
  }

  void _initScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        setState(() {});
        _fetchData();
      }
    });
  }

  _drawLoading() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
