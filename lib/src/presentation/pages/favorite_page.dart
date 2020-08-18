import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiFavourite.dart';
import 'package:appjeshua/src/presentation/widget/empty_state_widget.dart';
import 'package:appjeshua/src/presentation/widget/list_product_widget.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  ScrollController _scrollController = ScrollController();
  Utils utils = Utils();
  final _perpage = 10;
  bool _isLoading = false;
  int _page = 0;
  List<Product> _list = List();
  ApiFavourite api = ApiFavourite();

  @override
  void initState() {
    super.initState();
    _initScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listado de favoritos')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(children: <Widget>[_drawList(), _drawLoading()]),
      ),
    );
  }

  _drawList() {
    if (_list == null || _list.isEmpty) {
      _fetchData();
      emptyState();
      return Center(child: CircularProgressIndicator());
    } else {
      return ListProductWidget(
        products: _list,
        scrollController: _scrollController,
      );
    }
  }

  Widget emptyState() {
    return EmptyStateWidget(
      text: 'No posee favoritos.',
      path: 'assets/lottie_empty_favorite.json',
    );
  }

  _fetchData() async {
    _page++;
    final response = await api.getProductsFavourites(_page, _perpage);
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
