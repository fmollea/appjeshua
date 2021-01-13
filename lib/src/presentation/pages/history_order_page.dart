import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/OrderDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiOrder.dart';
import 'package:flutter/material.dart';

class HistoryOrderPage extends StatefulWidget {
  @override
  _HistoryOrderPageState createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  final _apiOrder = ApiOrder();
  Orders _listOrders = Orders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Historial de pedidos",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: _drawScreen());
  }

  Widget _drawScreen() {
    return FutureBuilder(
      future: _apiOrder.getOrders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _listOrders = snapshot.data;
          if (_listOrders.list.isEmpty) {
            return emptyState();
          } else {
            return Padding(
              padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 8),
              child: _drawListAddress());
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _drawListAddress() {
    return ListView.builder(
            shrinkWrap: true,
            itemCount: _listOrders.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _drawRowAddress(index);
            });
  }

  Widget _drawRowAddress(int index) {
    OrderDto item = _listOrders.list[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _drawTopCard(item.id),
              _drawCenterCard(item.create, item.total),
              _drawDayExpired(item.dayExpired),
              _drawBottomCard(item.paid, item.id)
            ],
          ))),
    );
  }

  _drawTopCard(String nro) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(children: [
        Text('No. Pedido: $nro', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
        Expanded(child: Text('Total', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])))
      ]),
    );
  }

  _drawCenterCard(String date, String total) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(children: [
        Text('Fecha: $date', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
        Expanded(child: Text('\$ $total MXM', style: TextStyle(color: Utils.secondaryColor, 
                  fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.right)),
      ]),
    );
  }

  _drawBottomCard(String state, String id) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text('$state',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), 
            textAlign: TextAlign.center),
          decoration: BoxDecoration(
            color: Utils.redColor,
            borderRadius: BorderRadius.all(Radius.circular(16))
          )),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('> Ver detalles',style: TextStyle(color: Utils.primaryColor, fontWeight: FontWeight.bold), 
                textAlign: TextAlign.right),
            ),
            onTap: () {
              _selectedOrder(id);
            },  
          )
        ))
      ]),
    );
  }

  Widget emptyState() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Card(
                child: ListTile(
              leading: Icon(Icons.shop, color: Utils.primaryColor),
              title: Text("No hay ordenes",
                  style: TextStyle(color: Colors.black87, fontSize: 18.0)),
              subtitle: Text("Aun no has realizado ninguna orden",
                  style: TextStyle(color: Colors.black54, fontSize: 16.0)),
            ))));
  }

  void _selectedOrder(String id) {
    User user = User();
    user.idOrder = id;
    Navigator.pushNamed(context, 'detail_order');
  }

  _drawDayExpired(int dayExpired) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: 
        Align(
          alignment: Alignment.topLeft,
          child: Text('Días vencidos: $dayExpired', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
        ),
    );
  }
}
