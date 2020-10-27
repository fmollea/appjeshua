import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/list_product_widget.dart';
import 'package:flutter/material.dart';


class ContentListProduct extends StatefulWidget {
  final Map<String, String> params;

  const ContentListProduct({Key key, this.params}) : super(key: key);

  @override
  _ContentListProductState createState() => _ContentListProductState();
}

class _ContentListProductState extends State<ContentListProduct> {
  ScrollController _scrollController = ScrollController();
  Utils utils = Utils();
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
    return Stack(children: <Widget>[_drawList(), _drawLoading()]);
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
    try {
      if (widget.params.containsKey('queryparam')) {
        final query = widget.params['queryparam'];
        response = await api.searchProductsByQueryParam(query, _perpage);
      }

      if (widget.params.containsKey('categoria_id')) {
        final category = widget.params['categoria_id'];
        response =
            await api.searchProductsByCategory(category, _page);
      }

      //si es una búsqueda por query, entonces muestro la lista de sugeridos. 
      if (widget.params.containsKey('queryparam')) {
        final query = widget.params['queryparam'];
        var listAux = response.list;
        final listSuggestions = (query.isEmpty)
            ? []
            : listAux
                .where(
                    (p) => p.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

        _list = _list + listSuggestions;
      } else {
        _list = _list + response.list;
      }
    } catch (e) {
      // al catch entra en caso de error o de que sea un listado normal.
      response = await api.getProducts(_page);
      _list = _list + response.list;
    }

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
