import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/cart.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
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
  double _totalAmount = 0;
  List<int> cartsUpdates = List();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Resumen de Compra",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Vaciar Carrito'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ]),
        body: _drawScreen(),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Vaciar Carrito': emptyCart();
        break;
    }
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
          _totalAmount + element.quantity * double.parse(element.product.price);
    });
  }

  navToPage() async {
    if (_totalAmount <= 0) {
      Utils.showToast("No tiene prodcutos seleccionados para comprar.",
          Colors.white, Colors.red);
    } else {
      User user = User();
      await updatesCarts();
      user.carts = listCarts.list;
      Navigator.pushNamed(context, 'delivery_point_page');
    }
  }

  Widget _drawRowPurchaseSummary(int index) {
    return Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
          children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/not_found.png',
                      image: listCarts.list[index].product.path,
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill)),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(listCarts.list[index].product.name,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                      Text('', style: TextStyle(fontSize: 8.0)),
                      Text(listCarts.list[index].product.description,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0), maxLines: 2),
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
        ),
            )));
  }

  _drawCantAndDelete(int index) {
    TextEditingController controller = TextEditingController();
    controller.text = listCarts.list[index].quantity.toString();
    return Row(
      key: UniqueKey(),
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: 32,
            height: 32,
            decoration:
              BoxDecoration(border: Border.all(color: Colors.black26)),
            child: Center(child:Text('-', style: TextStyle(fontSize: 16)))),
          onTap: () {
                  if (listCarts.list[index].quantity > 0) {
                    listCarts.list[index].quantity--;
                    _totalAmount = _totalAmount -
                        double.parse(listCarts.list[index].product.price);
                    cartsUpdates[index] = 1;
                    setState(() {});
                  }
                },
        ),
        Expanded(child: Container(
          height: 32,
          child: Center(
            child: Focus(
              onFocusChange: (hasFocus) {
                  if(hasFocus) {
                    controller.text = "";
                  } else {
                    checkTextField(controller);
                  }
              },
              child: TextField(
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              controller: controller,
              onChanged: (value) {
                if (value != null && int.parse(value) > 0) {
                    listCarts.list[index].quantity = int.parse(value);
                    _totalAmount = _totalAmount -
                        double.parse(listCarts.list[index].product.price);
                    cartsUpdates[index] = 1;
                  } else {
                    Utils.showToast(
                      "La cantidad seleccionada tiene que ser mayor a 0.", Colors.white, Colors.red);
                    setState(() {});
                  }
              },
              onEditingComplete: () {
                  checkTextField(controller);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
              )),
            ),
          ),
        ),
    )),
        GestureDetector(
          child: Container(
            height: 32,
            width: 32,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black26)),
            child: Center(child: Text('+', style: TextStyle(fontSize: 16)))),
            onTap: () {
                listCarts.list[index].quantity++;
                _totalAmount = _totalAmount +
                    double.parse(listCarts.list[index].product.price);
            cartsUpdates[index] = 1;
                setState(() {}); 
            }
        ),      
        Container(width: 8),          
        FlatButton(
          child: Text('ELIMINAR',
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold)),
          onPressed: () {
            final id = listCarts.list[index].product.id;
            cartsUpdates[index] = 0;
            _removeCart(id, index);
          },
        )
      ],
    );
  }

  checkTextField(TextEditingController controller) {
    if (controller.text == "") controller.text = "0";
    setState(() {});
  }

  _removeCart(int id, int index) async {
    ResponseDto response = await _apiCart.removeProducCart(id);
    if (NetworkUtils.isReqSuccess(response.code)) {
      
        _totalAmount = _totalAmount -
            listCarts.list[index].quantity *
                double.parse(listCarts.list[index].product.price);
        listCarts.list.removeAt(index);
    } else {
      Utils.showToast(
          "No se pudo eliminar el producto " +
              listCarts.list[index].product.name +
              " del carrito.",
          Colors.white,
          Colors.red);
    }
    setState(() {
      if (listCarts.list.length == 0) {
        listCarts.list = List<Cart>();
      }
    });
  }

  initArrayListOfUpdates() {
    cartsUpdates = List.filled(listCarts.list.length, 0);
  }

  Future<bool> onWillPop() async {
    Utils.showLoading(context);
    await updatesCarts();
    Utils.hideLoading(context);
    Navigator.of(context).pop(true);
  }

  Future updatesCarts() async {
    for(int i = 0; i< cartsUpdates.length; i++) {
      if (cartsUpdates[i] == 1) {
        await _updateCart(i, listCarts.list[i].quantity);
        print(listCarts.list[i].product.name);
      }
    }
  }

  Future _updateCart(int index, int amount) async {
    final id = listCarts.list[index].product.id;
    ResponseDto responseDto = await _apiCart.removeProducCart(id);
    if (NetworkUtils.isReqSuccess(responseDto.code)) {
      await _apiCart.addProductCart(amount, id);
    }
  }

  emptyCart() {
    if (listCarts.list.isNotEmpty) {
      Utils.showLoading(context);
      emptyCartApi();
      initArrayListOfUpdates();
    }
  }

  void emptyCartApi() async {
    ResponseDto responseDto = await _apiCart.emptyCart();
    if (NetworkUtils.isReqSuccess(responseDto.code)) {
      listCarts.list = List<Cart>();
      Utils.hideLoading(context);
    }
    setState(() {});    
  }
}
