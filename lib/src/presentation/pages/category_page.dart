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
    return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: [
          _drawRowCategories(context, 'cat_antibioticos', 'Antibioticos'),
          _drawRowCategories(context, 'cat_babys', 'Bebe'),
          _drawRowCategories(context, 'cat_ctlpeso', 'Peso'),
          _drawRowCategories(context, 'cat_diabeticos', 'Diabéticos'),
          _drawRowCategories(context, 'cat_dispmedic', 'Médicos'),
          _drawRowCategories(context, 'cat_higuieneper', 'Higiene Per'),
          _drawRowCategories(context, 'cat_mcosmeticos', 'Cosméticos'),
          _drawRowCategories(context, 'cat_medicamentos', 'Medicamentos'),
          _drawRowCategories(context, 'cat_nuevos', 'Nuevos'),
          _drawRowCategories(context, 'cat_promociones', 'Promociones'),
          _drawRowCategories(context, 'cat_rehidratantes', 'Rehidratantes'),
          _drawRowCategories(context, 'cat_vidasexual', 'Salud Sexual'),
        ]);
  }

  _drawRowCategories(BuildContext context, String path, String name) {
    return GestureDetector(
        onTap: () {
          Map<String, String> mapOfArgs = {"queryparam": ''};
          Navigator.pushNamed(context, 'products_page', arguments: mapOfArgs);
        },
        child: Padding(
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
        ));
  }
}
