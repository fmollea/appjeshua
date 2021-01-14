import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiFavourite.dart';
import 'package:appjeshua/src/presentation/widget/empty_state_widget.dart';
import 'package:appjeshua/src/presentation/widget/list_product_widget.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {

  final bool isBottomOptionPage;

  const FavoritePage({Key key, this.isBottomOptionPage = false}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

    ScrollController _scrollController = ScrollController();
    Utils utils = Utils();
    final _perpage = 10;
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
        appBar: _drawAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _drawPage(),
        ),
      );
    }

  _drawAppBar() {
    return widget.isBottomOptionPage ? AppBar(title: Text('Listado de favoritos'), leading: Container(), centerTitle: true,) :
      AppBar(title: Text('Listado de favoritos'), centerTitle: true,); 
  }

  _drawPage() {
    _page++;
    return FutureBuilder(
      future: api.getProductsFavourites(_page, _perpage),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) { 
            if ((snapshot.data.list as List<Product>).isNotEmpty && _checkList(snapshot.data.list[0])) {
              _list = _list + snapshot.data.list.reversed.toList();
            }
            if (_list.isEmpty) {
              return emptyState();
            } else {
              return ListProductWidget(
                products: _list,
                scrollController: _scrollController,
              );
            }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
  }

  void _initScrollController() {
    _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
        setState(() {});
        _drawPage();
      }
    });
  }

  Widget emptyState() {
    return EmptyStateWidget(
      text: 'No posee favoritos.',
      path: 'assets/lottie_empty_favorite.json',
    );
  }

  bool _checkList(Product product) {
    return !_list.contains(product);
  }
}