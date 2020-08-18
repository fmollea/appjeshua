import 'package:flutter/material.dart';
import 'package:appjeshua/src/core/models/cart.dart';

// ignore: must_be_immutable
class RowPurchaseSummary extends StatefulWidget {
  Cart _cart;

  RowPurchaseSummary(this._cart);

  @override
  _RowPurchaseSummaryState createState() => _RowPurchaseSummaryState(_cart);
}

class _RowPurchaseSummaryState extends State<RowPurchaseSummary> {
  Cart _cart;
  List<int> _listQuantity = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  _RowPurchaseSummaryState(this._cart);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Card(
            child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/not_found.png',
                    image: _cart.product.path,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill)),
            Expanded(
              child: SizedBox(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_cart.product.name,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    Text('', style: TextStyle(fontSize: 8.0)),
                    Text("Código: " + _cart.product.code,
                        style:
                            TextStyle(color: Colors.black54, fontSize: 16.0)),
                    Text('', style: TextStyle(fontSize: 8.0)),
                    Text(
                      '\$ ' + _cart.product.price + ' MXN',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    _drawCantAndDelete(),
                    Text('', style: TextStyle(fontSize: 8.0)),
                  ],
                ),
              ),
            )
          ],
        )));
  }

  _drawCantAndDelete() {
    return Row(
      children: <Widget>[
        _selectCant(),
        Expanded(child: Text('')),
        FlatButton(
          child: Text('ELIMINAR',
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold)),
          onPressed: _deleteCart,
        )
      ],
    );
  }

  _deleteCart() {}

  _selectCant() {
    return DropdownButton(
      style: TextStyle(color: Colors.black87, fontSize: 18),
      value: null,
      hint: Text('Cantidad: ' + _cart.amount.toString() + ' ',
          style: TextStyle(color: Colors.black54)),
      items: _listQuantity.map((quantity) {
        return DropdownMenuItem(
          child: new Text(quantity.toString()),
          value: quantity,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _cart.amount = value;
        });
      },
    );
  }
}
