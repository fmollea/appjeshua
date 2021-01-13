import 'package:flutter/material.dart';

class ContainerWidthBorder extends StatelessWidget {
  final Widget content;

  const ContainerWidthBorder({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
      child: Center(child: content),
    );
  }
}
