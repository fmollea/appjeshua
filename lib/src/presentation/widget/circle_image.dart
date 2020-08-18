import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String path;
  final double imgHeight;
  final double imgWidth;

  CircleImage(this.path, this.imgHeight, this.imgWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imgWidth,
      height: imgHeight,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.fill)),
    );
  }
}
