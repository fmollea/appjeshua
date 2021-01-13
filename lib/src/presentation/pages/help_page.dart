import 'package:appjeshua/src/commons/Utils.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Utils.titleContact, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
      body: drawScreen(),
    );
  }

  drawScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
      //  Padding(
      //    padding: const EdgeInsets.only(top:48.0, bottom: 32),
      //    child: Image.asset('assets/help.png'),
      //  ),
        drawText('Preguntas frecuentes', 'frequent_questions_page'),
        drawDivider(),
        drawText('Contáctanos', 'contact_web_page'),
        drawDivider(),
        drawText('Términos y privacidad', 'terms_privacy_page'),
        drawDivider(),
        drawText('Info. de la app', 'info_page'),
      ],
    );
  }

  drawHeader() {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('assets/banner.png'), fit: BoxFit.fitWidth),
        ]
    );
  }

  drawTile(String title, String subtitle, String path) {
    return Container(
        padding: EdgeInsets.only(left: 32),
        child: ListTile(
          title: Text(title, style: TextStyle(color: Colors.black87, fontSize: 18.0)),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.black54, fontSize: 16.0)),
          onTap: () {
            navToPage(path);
          },
        ));
  }

  drawText(String text, String path) {
    return Container(
        padding: EdgeInsets.only(left: 32),
        child: ListTile(
          title: Text(text, style: TextStyle(color: Colors.black87, fontSize: 18.0)),
          onTap: () {
            navToPage(path);
          },
        ));
  }

  drawDivider() {
    return Container(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Divider(color: Colors.grey, height: 2.0));
  }

  navToPage(String path) {
    Navigator.pushNamed(context, path);
  }
}