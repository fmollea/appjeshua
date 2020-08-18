import 'package:appjeshua/src/commons/Utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final List<Widget> items;

  const CarouselWidget({Key key, this.items}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      /*   decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 0.7),
          colors: <Color>[Utils.primaryColor, Colors.white],
        ),
      ),*/
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 2.4,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: widget.items),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.map((item) {
              int index = widget.items.indexOf(item);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Utils.redColor
                      : Utils.redColor.withOpacity(.3),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
