import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/presentation/pages/pills_page.dart';
import 'package:flutter/material.dart';
import 'package:appjeshua/src/presentation/widget/card_product_widget.dart';

class GridProductWidget extends StatelessWidget {
  final List<Product> categories;
  PillsPage pillsPage;

  GridProductWidget({@required this.categories, this.pillsPage});

  @override
  Widget build(BuildContext context) {
    SliverGrid result;

    if (categories == null || categories.isEmpty) {
      result = _circularProgress();
    } else {
      result = _drawGrid();
    }

    return result;
  }

  SliverGrid _circularProgress() {
    return SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        delegate: SliverChildListDelegate(
            [Center(child: CircularProgressIndicator())]));
  }

  Widget _drawGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 5.0),
      delegate: SliverChildListDelegate(
        categories
            .map((data) => Card(
                  elevation: 4.0,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: CardProductWidget(item: data, pillsPage: pillsPage),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
