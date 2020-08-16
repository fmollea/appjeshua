import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback action;
  final Color bacKColor;
  final String text;

  ButtonWidget(this.action, this.bacKColor, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            padding: EdgeInsets.all(16),
            shape: StadiumBorder(),
            onPressed: action,
            color: bacKColor,
            child: Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}
