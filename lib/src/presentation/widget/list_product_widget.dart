import 'package:flutter/material.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/presentation/widget/row_product_widget.dart';

class ListProductWidget extends StatelessWidget {
  final List<Product> products;
  final ScrollController scrollController;

  ListProductWidget({@required this.products, @required this.scrollController});

  @override
  Widget build(BuildContext context) {
    Widget result;

    if (products == null || products.isEmpty) {
      result = _circularProgress();
    } else {
      result = _drawList();
    }

    return result;
  }

  Widget _circularProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _drawList() {
    return ListView.builder(
        itemCount: products.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          final item = products[index];
          return RowProductWidget(item: item);
        });
  }
}
