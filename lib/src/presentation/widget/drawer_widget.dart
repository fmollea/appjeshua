import 'package:flutter/material.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'circle_image_widget.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final utils = Utils();
  final _user = User();

  @override
  Widget build(BuildContext context) {
    return Drawer(child: _drawContent());
  }

  _drawContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _drawDrawerHeader(),
        _listDrawerOptions(),
        _drawListTilelogin('log_out', 'Cerrar sesión', '/'),
      ],
    );
  }

  _listDrawerOptions() {
    return Expanded(
        child: Container(
      color: Utils.primaryColor,
      child: ListView(
        children: <Widget>[
          _drawListTile('products', 'Productos', 'products_page'),
          _drawListTile('category', 'Categorías', 'category_page'),
          _drawListTile('notification', 'Notificaciones', 'notification_page'),
          _drawListTile('cart', 'Mi carrito', 'purchase_summary_page'),
          _drawListTile('history', 'Historial', 'history_order_page'),
          _drawListTile('help', 'Ayuda', 'help_page'),
        ],
      ),
    ));
  }

  _drawDrawerHeader() {
    return Container(
      height: 190,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleImageWidget(path: getImagePath(), width: 90, height: 90),
          Container(width: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _user.name,
                style: TextStyle(
                    color: Utils.primaryColor,
                    fontSize: 18.0,
                    fontWeight:
                        FontWeight.bold),
              )
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: ExactAssetImage('assets/img_menulatera.png'),
        ),
      ),
    );
  }

  _drawListTile(String icon, String text, String path) {
    return ListTile(
      leading: utils.getIcon(icon, Colors.white),
      title: Text(text, style: TextStyle(color: Colors.white, fontSize: 18.0)),
      onTap: () {
        navToPage(path);
      },
    );
  }

  _drawListTilelogin(String icon, String text, String path) {
    return Container(
      color: Utils.redColor,
      child: ListTile(
        leading: utils.getIcon(icon, Colors.white),
        title:
            Text(text, style: TextStyle(color: Colors.white, fontSize: 18.0)),
        onTap: () {
          _closeSesion(path);
        },
      ),
    );
  }

  _closeSesion(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', '');
        prefs.setString('password', '');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false);
  }

  navToPage(String path) {
    Navigator.pushNamed(context, path);
  }

  String getImagePath() {
    if (_user.image == null) return null;
    else return Utils.getPerfilImage(_user.image, _user.userId);
  }
}
