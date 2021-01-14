import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/presentation/pagesviews/profile_page_view.dart';
import 'package:appjeshua/src/presentation/presenters/profile_presenter.dart';
import 'package:appjeshua/src/presentation/widget/circle_image_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  final bool isBottomOptionPage;

  const ProfilePage({Key key, this.isBottomOptionPage = false}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> implements ProfilePageView {
  Utils _utils;
  ProfilePresenter _presenter;
  User _user;

  @override
  void initState() {
    super.initState();
    _presenter = ProfilePresenter();
    _presenter.attachView(this);
    _utils = Utils();
    _user = User();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _drawAppBar(),
      body: drawScreen(),
    );
  }

  _drawAppBar() {
    return widget.isBottomOptionPage ? AppBar(title: Text(Utils.titleProfile), leading: Container(), centerTitle: true,) :
      AppBar(title: Text(Utils.titleProfile), centerTitle: true,); 
  }

  drawScreen() {
    return SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          drawHeader(),
          drawOptions('Historial de pedidos', 'history', 'history_order_page'),
          drawDivider(),
          drawOptions('Datos personales', 'person', 'details_profile'),
          drawDivider(),
          drawOptions('Lista de deseos', 'not_fav', 'favorite_page'),
        ],
      ),
    );
  }

  drawHeader() {
    return Container(
        padding: EdgeInsets.only(top: 36, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Column(
            children: <Widget>[
              CircleImageWidget(path: getImagePath(), width: 90, height: 90),
              Text(' ', style: TextStyle(fontSize: 12.0)),
              Text(
                  _user.name,
                  style: TextStyle(
                      color: Utils.redColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              Text(' ', style: TextStyle(fontSize: 8.0)),
            ],
          )
        ]));
  }

  drawOptions(String title, String icon, String path) {
    return Container(
      padding: EdgeInsets.only(left: 32),
      child: ListTile(
        leading: _utils.getIcon(icon, Colors.grey[600]),
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

  @override
  navToPage(String path) {
    Navigator.pushNamed(context, path);
  }

  String getImagePath() {
    if (_user.image == null) return null;
    else return Utils.getPerfilImage(_user.image, _user.userId);
  }
}