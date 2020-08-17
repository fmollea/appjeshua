import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/deliveryAddress.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiDeliveryAddress.dart';
import 'package:flutter/material.dart';

class ProfileDeliveryPage extends StatefulWidget {
  @override
  _ProfileDeliveryPageState createState() => _ProfileDeliveryPageState();
}

class _ProfileDeliveryPageState extends State<ProfileDeliveryPage> {
  final _apiDelivery = ApiDeliveryAddress();
  DeliveryAddresses listAddress = DeliveryAddresses();
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Punto de entrega",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: addAddress,
            )
          ],
        ),
        body: _drawScreen());
  }

  Widget _drawScreen() {
    return FutureBuilder(
      future: _apiDelivery.listDeliveryAddress(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          listAddress = snapshot.data;
          if (listAddress.list.isEmpty) {
            return emptyState();
          } else {
            return Padding(
              padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 8),
              child: _drawListAddress(),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget emptyState() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Card(
                child: ListTile(
              onTap: addAddress,
              leading:
                  Icon(Icons.add_circle_outline, color: Utils.primaryColor),
              title: Text("Agregar dirección",
                  style: TextStyle(color: Colors.black87, fontSize: 18.0)),
              subtitle: Text(
                  "Agregue la dirección donde desea recibir su pedido",
                  style: TextStyle(color: Colors.black54, fontSize: 16.0)),
            ))));
  }

  Widget _drawListAddress() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listAddress.list.length,
        itemBuilder: (BuildContext context, int index) {
          return _drawRowAddress(index);
        });
  }

  void addAddress() {
    Navigator.pushNamed(context, 'add_deliver_address_page');
  }

  Widget _drawRowAddress(int index) {
    DeliveryAddress item = listAddress.list[index];

    return Card(
      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: ListTile(
          onTap: () {
            _editAddress(index);
          },
          title: Text(item.name, style: TextStyle(fontSize: 18.0)),
          subtitle: Row(children: <Widget>[
            Text(item.address + ' ', style: TextStyle(fontSize: 16.0)),
            Text(item.postalCode + ', ' + item.city,
                style: TextStyle(fontSize: 16.0))
          ]),
          trailing: InkResponse(
              child: Icon(Icons.delete),
              onTap: () {
                _deleteAddress(index);
              })),
    );
  }

  void _editAddress(int index) async {
    final id = listAddress.list[index].id;
    Navigator.pushNamed(context, 'edit_delivery_page', arguments: id);
  }

  void _deleteAddress(int index) async {
    final id = listAddress.list[index].id;
    final response = await _apiDelivery.removeDeliveryAddress(id);

    if (NetworkUtils.isReqSuccess(response.code)) {
      Utils.showToast(
          "Dirección eliminada correctamente.", Colors.white, Colors.green);
      setState(() {});
    } else {
      Utils.showToast(
          "No se pudo eliminar la dirección.", Colors.white, Colors.red);
    }
  }
}
