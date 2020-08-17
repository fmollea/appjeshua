import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/OrderDto.dart';
import 'package:appjeshua/src/core/services/apiOrder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              child: Column(
                children: <Widget>[
                  _drawListAddress(),
                ],
              ),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _drawListAddress() {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _listOrders.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _drawRowAddress(index);
            }));
  }

  Widget _drawRowAddress(int index) {
    final dateFormat = new DateFormat('dd-MM-yyyy');
    OrderDto item = _listOrders.list[index];

    return Card(
      child: ListTile(
        leading: Icon(Icons.shop, color: Utils.primaryColor),
        title: Text("Fecha " + dateFormat.format(item.create),
            style: TextStyle(color: Colors.black87, fontSize: 18.0)),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Estado " + item.status,
                  style: TextStyle(color: Colors.black87, fontSize: 18.0)),
              Row(
                children: <Widget>[
                  Expanded(child: Text('')),
                  Text('\$ ${item.total} MXN',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ]),
      ),
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

  void _selectedOrder(int index) {}
}
