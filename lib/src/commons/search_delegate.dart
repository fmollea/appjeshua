import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/content_list_product.dart';
import 'package:flutter/material.dart';
import '../core/models/product.dart';
import '../core/services/apiProduct.dart';
import 'Utils.dart';

class DataSearch extends SearchDelegate {
  Utils utils = Utils();
  List<Product> _list = List();
  ApiProduct api = ApiProduct();

  final String filter;

  DataSearch(this.filter);

  @override
  String get searchFieldLabel => 'Buscar productos';

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
    Map<String, String> params = {'queryparam': query, 'category': filter, 'title': 'Ofertas'};
    return ContentListProduct(params: params);  
  }

    @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: api.searchProductsByQueryParam(query, 20),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Products products = snapshot.data;
            _list = products.list;
            final listSuggestions = (query.isEmpty)
                ? []
                : _list
                    .where((p) => 
                         (filter == 'none' || p.slugCategory == filter)) 
                    .toList();

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView(children: listSuggestions.map((product) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(Utils.getProductImage(product.path, product.id)),
                    placeholder: AssetImage('assets/not_found.png'),
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(product.name),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'products_detail_page',
                        arguments: product.slug);
                  },
                );
              }).toList()),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
