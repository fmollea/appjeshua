import 'package:appjeshua/src/commons/Utils.dart';
import 'package:flutter/material.dart';

class ContentDialog extends StatelessWidget {
  final String pathImg;
  final String title;
  final String subtitle;
  final String textPrimaryAction;
  final String textSecondaryAction;
  final VoidCallback primaryAction;
  final VoidCallback secondaryAction;

  const ContentDialog(
      {Key key,
      this.pathImg,
      this.title,
      this.subtitle,
      this.textPrimaryAction,
      this.textSecondaryAction,
      this.primaryAction,
      this.secondaryAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
              Icons.check_circle_outline,
              color: Utils.redColor,
              size: 72),
          Container(height: 12),
          Text(title,
              style: TextStyle(
                  color: Utils.redColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Text(subtitle, style: TextStyle(color: Colors.black87, fontSize: 18)),
          Container(height: 16),
          FlatButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(textPrimaryAction,
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
            onPressed: primaryAction,
            color: Utils.primaryColor,
          ),
          FlatButton(
            child: Text(textSecondaryAction,
                style: TextStyle(color: Colors.black54, fontSize: 14)),
            onPressed: secondaryAction,
          )
        ],
      ),
    );
  }
}
