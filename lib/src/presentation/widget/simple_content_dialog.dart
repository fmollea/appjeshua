import 'package:appjeshua/src/commons/Utils.dart';
import 'package:flutter/material.dart';

class SimpleContentDialog extends StatelessWidget {
  final String pathImg;
  final String title;
  final String textAction;
  final VoidCallback action;

  const SimpleContentDialog(
      {Key key,
      this.pathImg,
      this.title,
      this.textAction,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
              pathImg,
              color: Utils.blueAccent,
              width: 72,
              height: 72),
          Container(height: 12),
          Text(title,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18)),
          Container(height: 16),
          FlatButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(textAction,
                  style: TextStyle(color: Utils.redColor, fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            onPressed: action,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
