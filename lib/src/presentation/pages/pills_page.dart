import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/commons/search_delegate.dart';
import 'package:appjeshua/src/core/models/category.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiCategory.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/carousel_widget.dart';
import 'package:appjeshua/src/presentation/widget/drawer_widget.dart';
import 'package:appjeshua/src/presentation/widget/grid_product_widget.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PillsPage extends StatefulWidget {
  @override
  _PillsPageState createState() => _PillsPageState();
}

class _PillsPageState extends State<PillsPage> {
  User user = User();


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
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top:12.0, right: 12, bottom: 12),
                child: Badge(
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(user.cantCarts.toString(), style: TextStyle(color: Colors.white)),
                  child: Icon(Icons.shopping_cart, color: Colors.white)),
              ),
              onTap: () {
                navToCart();
              },
            ),
          Container(width: 8),  
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
      future: apiProduct.getProducts(1),
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
    final apiCategory = ApiCategory();
    return FutureBuilder(
      future: apiCategory.getCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Category> list;
        if (snapshot.hasData) {
          list = (snapshot.data as Categories).list.reversed.toList();

          return SliverFixedExtentList(
            itemExtent: 100,
            delegate: SliverChildListDelegate([(
              ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final item = list[index];
                  return _drawRowCategories(item.image, item.name, item.slug);
                },
              ))
            ]),
          );
        } else {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            delegate: SliverChildListDelegate([Center(child: CircularProgressIndicator())]));
        }

        
      },
    );
  }

  _drawRowCategories(String path, String name, String slug) {
    return GestureDetector(
      onTap: () {
        navToProductList(slug);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
             FadeInImage.assetNetwork(
              placeholder: Utils.placeHolderPath,
              image: Utils.getCategoryImage(path),
              fit: BoxFit.fill,
              height: 70,
              width: 70),
            Container(height: 2),
            Text(name)
          ],
        ),
      ),
    );
  }

  void navToCart() {
    Navigator.pushNamed(context, 'purchase_summary_page');
  }

  void navToProductList(String slug) {
    Map<String, String> mapOfArgs = {"category": slug};
    Navigator.pushNamed(context, 'products_page', arguments: mapOfArgs);
  }
}
