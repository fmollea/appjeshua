import 'package:appjeshua/src/commons/Utils.dart';
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
                actual >= 1
                    ? Icon(Icons.check_circle,
                        color: Utils.redColor, size: 32)
                    : Icon(Icons.check_circle_outline,
                        color: Colors.grey, size: 32),
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
              actual >= 2
                  ? Icon(Icons.check_circle, color: Utils.redColor, size: 32)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 32),
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
              actual >= 3
                  ? Icon(Icons.check_circle, color: Utils.redColor, size: 32)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 32),
              Expanded(child: Container())
            ])
          ],
        ))
      ],
    );
  }
}
