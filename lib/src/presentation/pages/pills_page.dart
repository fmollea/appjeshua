import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/carousel_widget.dart';
import 'package:appjeshua/src/presentation/widget/drawer_widget.dart';
import 'package:appjeshua/src/presentation/widget/grid_product_widget.dart';
import 'package:appjeshua/src/presentation/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PillsPage extends StatefulWidget {
  @override
  _PillsPageState createState() => _PillsPageState();
}

class _PillsPageState extends State<PillsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Image(
            image: AssetImage('assets/logo_intro.png'),
            height: 50.0,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: navToCart,
            )
          ],
        ),
        drawer: DrawerWidget(),
        body: Container(child: drawView()));
  }

  drawView() {
    return CustomScrollView(
      slivers: <Widget>[
        _imageBanner(),
        SliverPadding(padding: EdgeInsets.all(8.0)),
        _drawCategories(),
        SliverPadding(padding: EdgeInsets.all(8.0)),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: _drawGrid()),
      ],
    );
  }

  _drawGrid() {
    final apiProduct = ApiProduct();
    return FutureBuilder(
      future: apiProduct.getProducts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Product> list;
        if (snapshot.data != null) {
          list = (snapshot.data as Products).list.reversed.toList();
        }
        return GridProductWidget(categories: list);
      },
    );
  }

  _imageBanner() {
    return SliverList(
        delegate: SliverChildListDelegate([
      SearchWidget(),
      CarouselWidget(
        items: [
          Image(image: AssetImage('assets/slidedemo.png'), fit: BoxFit.fill),
          Image(image: AssetImage('assets/slidedemo.png'), fit: BoxFit.fill),
          Image(image: AssetImage('assets/slidedemo.png'), fit: BoxFit.fill),
        ],
      )
    ]));
  }

  _drawCategories() {
    return SliverFixedExtentList(
      itemExtent: 100,
      delegate: SliverChildListDelegate([
        (ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _drawRowCategories('cat_antibioticos', 'Antibioticos'),
            _drawRowCategories('cat_babys', 'Bebe'),
            _drawRowCategories('cat_ctlpeso', 'Peso'),
            _drawRowCategories('cat_diabeticos', 'Diabéticos'),
            _drawRowCategories('cat_dispmedic', 'Médicos'),
            _drawRowCategories('cat_higuieneper', 'Higiene Per'),
            _drawRowCategories('cat_mcosmeticos', 'Cosméticos'),
            _drawRowCategories('cat_medicamentos', 'Medicamentos'),
            _drawRowCategories('cat_nuevos', 'Nuevos'),
            _drawRowCategories('cat_promociones', 'Promociones'),
            _drawRowCategories('cat_rehidratantes', 'Rehidratantes'),
            _drawRowCategories('cat_vidasexual', 'Salud Sexual'),
          ],
        ))
      ]),
    );
  }

  _drawRowCategories(String path, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image(
              image: AssetImage('assets/$path.png'),
              fit: BoxFit.fill,
              height: 70,
              width: 70),
          Container(height: 2),
          Text(name)
        ],
      ),
    );
  }

  void navToCart() {
    Navigator.pushNamed(context, 'purchase_summary_page');
  }
}
