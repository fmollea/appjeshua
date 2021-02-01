import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/presentation/widget/circle_image.dart';
import 'package:flutter/material.dart';

class MilestoneWidget extends StatelessWidget {
  final int actual;

  const MilestoneWidget({Key key, this.actual}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(child: Container()),
                _drawCircle('assets/car_po2.png', 'assets/car_2.png', 36, 1),
                Expanded(
                    child: Container(
                  color: actual >= 2 ? Utils.redColor : Colors.grey,
                  height: 2,
                )),
              ])
            ],
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Expanded(
                  child: Container(
                      color: actual >= 2 ? Utils.redColor : Colors.grey,
                      height: 2)),
              _drawCircle('assets/car_po3.png', 'assets/car_3.png', 36, 2),
              Expanded(
                  child: Container(
                      color: actual >= 3 ? Utils.redColor : Colors.grey,
                      height: 2)),
            ])
          ],
        )),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Expanded(
                  child: Container(
                      color: actual >= 3 ? Utils.redColor : Colors.grey,
                      height: 2)),
              _drawCircle('assets/car_po4.png', 'assets/car_4.png', 36, 3),
              Expanded(child: Container())
            ])
          ],
        ))
      ],
    );
  }

  _drawCircle(String path, String pathGray, double size, int current) {
    return actual >= current
      ? (_drawImage(path, size,))
      : (_drawImage(pathGray, size,));
  }

  _drawImage(String path, double size) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.fill)),
    );
  }
}
