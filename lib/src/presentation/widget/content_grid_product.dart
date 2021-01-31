import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/grid_product_widget.dart';
import 'package:flutter/material.dart';

class ContentGridProduct extends StatefulWidget {
 
  @override
  _ContentGridProductState createState() => _ContentGridProductState();
} 


class _ContentGridProductState extends State<ContentGridProduct> {

  ScrollController _scrollController = ScrollController();
  Utils utils = Utils();
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
    return Stack(children: <Widget>[ _drawGrid(), _drawLoading()]);
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

  Widget _drawGrid() {
    _page++;
    if (_list == null || _list.isEmpty) {
      _fetchData();
      return Center(child: CircularProgressIndicator());
    } else {
      return SliverToBoxAdapter(
          child: GridProductWidget(categories: _list));
    }
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

  _fetchData() async {
    _page++;
    Products response = await api.getProducts(_page);
    _list = _list + response.list.reversed.toList();
    _drawGrid();
    _isLoading = false;
    setState(() {});
  }
}