import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/content_list_product.dart';
import 'package:flutter/material.dart';
import '../core/models/product.dart';
import '../core/services/apiProduct.dart';
import 'Utils.dart';

class DataSearch extends SearchDelegate {
  ScrollController _scrollController = ScrollController();
  Utils utils = Utils();
  List<Product> _list = List();
  ApiProduct api = ApiProduct();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
        color: Colors.black87,
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
      color: Colors.black87,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final Map<String, String> params = {'queryparam': query};
    return ContentListProduct(params: params);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: api.searchProductsByQueryParam(query, 10),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Products products = snapshot.data;
            _list = products.list;

            final listSuggestions = (query.isEmpty)
                ? []
                : _list
                    .where((p) =>
                        p.name.toLowerCase().contains(query.toLowerCase()))
                    .toList();

            return ListView(children: listSuggestions.map((product) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(product.path),
                  placeholder: AssetImage('assets/not_found.png'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(product.name),
                onTap: () {
                  Navigator.pushNamed(context, 'products_detail_page',
                      arguments: product.id);
                },
              );
            }).toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
