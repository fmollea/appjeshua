import 'package:flutter/material.dart';
import 'package:appjeshua/src/commons/Utils.dart';

import 'alert_widget.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String args = "";

  @override
  Widget build(BuildContext context) {
    return _drawWidget();
  }

  Widget _drawWidget() {
    return Container(
        color: Utils.primaryColor,
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_searchText(), _buttonSearch()],
        ));
  }

  Widget _searchText() {
    return Expanded(
        child: Container(
            height: 48,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  cursorColor: Utils.primaryColor,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: "Busca aquí tu producto..",
                    hintStyle: TextStyle(color: Colors.black87),
                  ),
                  onChanged: (value) => setState(() {
                    args = value;
                  }),
                ),
              ),
            ])));
  }

  Widget _buttonSearch() {
    return Padding(
      padding: EdgeInsets.only(left: 4),
      child: InkResponse(
        child: Icon(
          Icons.search,
          color: Colors.white,
          size: 32,
        ),
        onTap: navToPage,
      ),
    );
  }

  navToPage() {
    if (args.isNotEmpty) {
      Map<String, String> mapOfArgs = {"queryparam": args};

      Navigator.pushNamed(context, 'products_page', arguments: mapOfArgs);
    } else {
      showAlertDialog(
          "Campo vacío", "Ingrese el nombre del producto que desea buscar.");
    }
  }

  showAlertDialog(String title, String content) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertWidget(title: title, content: content);
        });
  }
}
