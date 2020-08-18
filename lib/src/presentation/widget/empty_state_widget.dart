import 'package:appjeshua/src/commons/Utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  final String text;
  final String path;

  const EmptyStateWidget({Key key, this.text, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _drawLottieAnimation(),
        Container(
          height: 16.0,
        ),
        Text(text,
            maxLines: 2,
            style: TextStyle(color: Colors.black54, fontSize: 24),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget _drawLottieAnimation() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      color: Utils.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Lottie.asset(path,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
            repeat: true,
            animate: true),
      ),
    );
  }
}
