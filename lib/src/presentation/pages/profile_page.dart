import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/presentation/pagesviews/profile_page_view.dart';
import 'package:appjeshua/src/presentation/presenters/profile_presenter.dart';
import 'package:appjeshua/src/presentation/widget/circle_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> implements ProfilePageView {
  Utils _utils;
  ProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ProfilePresenter();
    _presenter.attachView(this);
    _utils = Utils();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person_pin, color: Colors.white),
        centerTitle: true,
        title: Text(Utils.titleProfile,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: drawScreen(),
    );
  }

  drawScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        drawHeader(),
        drawOptions('Historial de pedidos', 'history', 'history_order_page'),
        drawDivider(),
        drawOptions('Direcciones de envío', 'shipping_address',
            'profile_delivery_page'),
        drawDivider(),
        drawOptions('Direcciones de facturación', 'billing_address',
            'profile_billings_page'),
        drawDivider(),
        drawOptions('Datos personales', 'person', 'personal_info_page'),
      ],
    );
  }

  drawHeader() {
    final user = User();
    return Container(
        padding: EdgeInsets.only(top: 36, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.grey[350],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Column(
            children: <Widget>[
              CircleImage('assets/img_persona.png', 90, 90),
              Text(' ', style: TextStyle(fontSize: 12.0)),
              Text(user.name,
                  style: TextStyle(
                      color: Utils.primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              Text(' ', style: TextStyle(fontSize: 8.0)),
              _textEditProfile('edit_profile', 'Editar perfil')
            ],
          )
        ]));
  }

  drawOptions(String title, String icon, String path) {
    return Container(
      padding: EdgeInsets.only(left: 32),
      child: ListTile(
        leading: _utils.getIcon(icon, Utils.redColor),
        title: Text(title,
            style: TextStyle(color: Colors.black54, fontSize: 18.0)),
        onTap: () {
          _presenter.navToPage(path);
        },
      ),
    );
  }

  drawDivider() {
    return Container(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Divider(color: Colors.grey, height: 2.0));
  }

  Widget _textEditProfile(String path, String text) {
    return InkResponse(
      child:
          Text(text, style: TextStyle(color: Colors.black45, fontSize: 18.0)),
      onTap: () {
        _presenter.navToPage(path);
      },
    );
  }

  @override
  navToPage(String path) {
    Navigator.pushNamed(context, path);
  }
}
