import 'package:flutter/material.dart';
import 'package:appjeshua/src/commons/Utils.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String content;

  AlertWidget({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return _mostrarAlerta(context);
  }

  Widget _mostrarAlerta(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text('Aceptar'),
          onPressed: () => Navigator.of(context).pop(),
          textColor: Utils.primaryColor,
        )
      ],
    );
  }
}
