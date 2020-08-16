import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String text;
  final bool isPass;
  final TextInputType type;
  final TextEditingController controller;
  final Widget prefixIcon;

  TextInputWidget(
      {this.text, this.isPass, this.type, this.controller, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: TextField(
        style: TextStyle(color: Colors.black87),
        obscureText: isPass,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: text,
            hintStyle: TextStyle(color: Colors.black54),
            prefixIcon: prefixIcon),
      ),
    );
  }
}
