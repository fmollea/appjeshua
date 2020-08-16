import 'package:appjeshua/src/presentation/pages/login_page.dart';
import 'package:appjeshua/src/presentation/widget/bar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          BarWdiget(),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 48.0, right: 48.0),
            child: LoginPage(),
          )
        ]));
  }
}
