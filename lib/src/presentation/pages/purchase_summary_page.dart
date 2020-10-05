import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/cart.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiCart.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:flutter/material.dart';

class PurchaseSumaryPage extends StatefulWidget {
  @override
  _PurchaseSumaryPageState createState() => _PurchaseSumaryPageState();
}

class _PurchaseSumaryPageState extends State<PurchaseSumaryPage> {
  ApiCart _apiCart = ApiCart();
  Carts listCarts = Carts();
  List<int> _listQuantity = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  double _totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Resumen de Compra",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold))),
      body: _drawScreen(),
    );
  }

  Widget _drawScreen() {
    return FutureBuilder(
      future: _apiCart.getProductsCart(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (listCarts.list.isEmpty) {
            listCarts = snapshot.data;
          }
          _obtainTotal();
          return Column(
            children: <Widget>[
              _drawCartResume(),
              Text('', style: TextStyle(fontSize: 8)),
              _drawCartList(),
              Padding(
                  padding: EdgeInsets.only(right: 24, left: 24, bottom: 8),
                  child:
                      ButtonWidget(navToPage, Utils.primaryColor, "Siguiente")),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _drawCartList() {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: listCarts.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _drawRowPurchaseSummary(index);
            }));
  }

  Widget _drawCartResume() {
    return Container(
        height: 48,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8),
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
                    'Tienes ' + listCarts.list.length.toString() + ' árticulos',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold))),
            Text(
              '\$ $_totalAmount MXN',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  _obtainTotal() {
    _totalAmount = 0;
    listCarts.list.forEach((element) {
      _totalAmount =
          _totalAmount + element.amount * double.parse(element.product.price);
    });
  }

  navToPage() {
    if (_totalAmount <= 0) {
      Utils.showToast("No tiene prodcutos seleccionados para comprar.",
          Colors.white, Colors.red);
    } else {
      Navigator.pushNamed(context, 'delivery_point_page');
    }
  }

  // TODO ver la forma de ponerlo en el widget
  Widget _drawRowPurchaseSummary(int index) {
    return Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Card(
            child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/not_found.png',
                    image: listCarts.list[index].product.path,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill)),
            Expanded(
              child: SizedBox(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(listCarts.list[index].product.name,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    Text('', style: TextStyle(fontSize: 8.0)),
                    Text("Código: " + listCarts.list[index].product.code,
                        style:
                            TextStyle(color: Colors.black54, fontSize: 16.0)),
                    Text('', style: TextStyle(fontSize: 8.0)),
                    Text(
                      '\$ ${listCarts.list[index].product.price} MXN',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    _drawCantAndDelete(index),
                    Text('', style: TextStyle(fontSize: 8.0)),
                  ],
                ),
              ),
            )
          ],
        )));
  }

  _drawCantAndDelete(int index) {
    return Row(
      children: <Widget>[
        _selectCant(index),
        Expanded(child: Text('')),
        FlatButton(
          child: Text('ELIMINAR',
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold)),
          onPressed: () {
            final id = listCarts.list[index].product.id;
            _removeCart(id, index);
          },
        )
      ],
    );
  }

  _removeCart(int id, int index) async {
    ResponseDto response = await _apiCart.removeProducCart(id);
    if (NetworkUtils.isReqSuccess(response.code)) {
      setState(() {
        _totalAmount = _totalAmount -
            listCarts.list[index].amount *
                double.parse(listCarts.list[index].product.price);
        listCarts.list.removeAt(index);
      });
    } else {
      Utils.showToast(
          "No se pudo eliminar el producto " +
              listCarts.list[index].product.name +
              " del resumen de compra.",
          Colors.white,
          Colors.red);
    }
  }

  _selectCant(int index) {
    return DropdownButton(
      style: TextStyle(color: Colors.black87, fontSize: 18),
      value: null,
      hint: Text('Cantidad: ' + listCarts.list[index].amount.toString() + ' ',
          style: TextStyle(color: Colors.black54)),
      items: _listQuantity.map((quantity) {
        return DropdownMenuItem(
          child: new Text(quantity.toString()),
          value: quantity,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _totalAmount = _totalAmount -
              listCarts.list[index].amount *
                  double.parse(listCarts.list[index].product.price) +
              value * double.parse(listCarts.list[index].product.price);
          listCarts.list[index].amount = value;
          _updateCart(index, value);
        });
      },
    );
  }

  void _updateCart(int index, int amount) async {
    final id = listCarts.list[index].product.id;
    ResponseDto responseDto = await _apiCart.removeProducCart(id);
    if (NetworkUtils.isReqSuccess(responseDto.code)) {
      await _apiCart.addProductCart(amount, id);
    }
  }
}
