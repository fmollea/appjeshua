import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/category.dart';
import 'package:appjeshua/src/core/services/apiCategory.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _drawAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: _drawView(context),
      ),
    );
  }

  Widget _drawAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Categorías',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _drawView(BuildContext context) {
    final apiCategory = ApiCategory();
    return FutureBuilder(
      future: apiCategory.getCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Category> list;
        if (snapshot.hasData) {
          list = (snapshot.data as Categories).list.reversed.toList();
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: list.map((item) => _drawRowCategories(context, item.image, item.name, item.slug )).toList()
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _drawRowCategories(BuildContext context, String path, String name, String slug) {
    return GestureDetector(
        onTap: () {
          Map<String, String> mapOfArgs = {"category": slug, "title": name};
          Navigator.pushNamed(context, 'products_page', arguments: mapOfArgs);
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
        ));
  }
}
