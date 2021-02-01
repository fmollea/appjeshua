import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/grid_product_widget.dart';
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
  List<String> _listFilters = ['De la A a la Z', 'De la Z a la A' ,'De mayor a menor precio', 'De menor a mayor precio'];
  String _filterSelected = 'De la A a la Z';
  bool filter = true;
  String filterCat;
  User user = User();

  @override
  void initState() {
    super.initState();
    _initScrollController();
    _initFilterCat();
    user.filterUrl = 'a-z';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[_drawFilter(), Padding(
        padding: const EdgeInsets.only(top: 56.0),
        child: _drawList()), _drawLoading()]);
  }

  _drawList() {
     if (_list == null || _list.isEmpty) {
      _fetchData();
      return Center(child: CircularProgressIndicator());
    } else {
      try {
        if (widget.params.containsKey('category') && widget.params['category'] == "promociones") {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(slivers: <Widget>[ GridProductWidget(categories: _list)]),
          );
        } else {
          return ListProductWidget(
            products: _list,
            scrollController: _scrollController,
          );
        }
      } catch (e) {
        return ListProductWidget(
            products: _list,
            scrollController: _scrollController
        );
      }
    }
  }

  _fetchData() async {
    _page = _page + 1;
    Products response;
    try {
      if (widget.params.containsKey('queryparam')) {
        final query = widget.params['queryparam'];
        response = await api.searchProductsByQueryParam(query, _perpage, _page);
      }

      if (widget.params.containsKey('category') && widget.params['category'] != 'none') {
        final category = widget.params['category'];
        response =
            await api.searchProductsByCategory(category, _page);
      }

      if (widget.params.containsKey('queryparam')) {
        final query = widget.params['queryparam'];
        var listAux = response.list.toList();
        final listSuggestions = (query.isEmpty)
            ? []
            : listAux
                .where((p) =>
                         (filterCat == 'none' || p.slugCategory == filterCat)) 
                    .toList();

        _list = _list + listSuggestions;
      } else {
        _list = _list + response.list.toList();
      }
    } catch (e) {
      response = await api.getProducts(_page);
      _list = _list + response.list.toList();
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

   _drawFilter() {
    return _filter();
  }

  _filter() {
    return Align(
      alignment: Alignment.topRight,
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton(
            style: TextStyle(color: Colors.black87, fontSize: 16),
            isExpanded: false,
            value:  _filterSelected,
            items: _listFilters.map((type) {
              return DropdownMenuItem(
                child: new Text(type),
                value: type,
              );
            }).toList(),
            onChanged: (value) {
              _filterSelected = value;
                _asignedFilter();
                _list = List();
                _page = 0;
              setState(() {
              });
            }),
        ),
    );
  }

  _asignedFilter() {
    switch (_filterSelected) {
      case 'De la A a la Z' : user.filterUrl = 'a-z';
        break;
      case 'De la Z a la A' : user.filterUrl = 'z-a';
        break;
      case 'De menor a mayor precio' : user.filterUrl = 'price-a';
        break;
      case 'De mayor a menor precio' : user.filterUrl = 'price-z';
        break;  
    }
  }

  void _initFilterCat() {
    if (widget.params != null && widget.params.containsKey('category')) {
        filterCat = widget.params['category'];
    }
  }
}
