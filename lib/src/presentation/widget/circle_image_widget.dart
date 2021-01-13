import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {

  final String path;
  final double width;
  final double height;

  const CircleImageWidget({Key key, @required this.path, @required this.width, @required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.fill,
            image: path == null ? AssetImage('assets/default_perfil.jpg') : NetworkImage(path)
        )
      )
    );
  }
}