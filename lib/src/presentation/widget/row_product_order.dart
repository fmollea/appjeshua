import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/cart.dart';
import 'package:flutter/material.dart';


class RowProductOrderWidget extends StatefulWidget {
  final Cart item;

  RowProductOrderWidget({@required this.item});

  @override
  _RowProductOrderWidgetState createState() => _RowProductOrderWidgetState(item: item);
}

class _RowProductOrderWidgetState extends State<RowProductOrderWidget> {
  final Cart item;
  final Utils utils = Utils();

  _RowProductOrderWidgetState({@required this.item});

  @override
  Widget build(BuildContext context) {
    return _drawCard(context);
  }

  Widget _drawCard(BuildContext context) {
   return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
          children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/not_found.png',
                      image: Utils.getProductImage(item.product.path, item.product.id),
                      width: 75,
                      height: 75,
                      fit: BoxFit.fill)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.product.name,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                    Container(height: 8),
                    Text(
                      '\$ ${item.product.price} MXN',
                      style: TextStyle(
                          color: Utils.secondaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(height: 8),
                    Text('Cantidad: ${item.quantity}'),
                    Container(height: 8),
                  ],
                ),
              )
          ],
        ),
            ));
    }
  }