import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiBillingAddress.dart';
import 'package:flutter/material.dart';

class ProfileBillingsPage extends StatefulWidget {
  @override
  _ProfileBillingsPageState createState() => _ProfileBillingsPageState();
}

class _ProfileBillingsPageState extends State<ProfileBillingsPage> {
  final _apiBillingAddress = ApiBillingAddress();
  BillingAddresses listAddress = BillingAddresses();
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Direcciones de facturación",
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
      future: _apiBillingAddress.listBillingAddress(),
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
              subtitle: Text("Agregue la dirección de facturación",
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
    Navigator.pushNamed(context, 'add_billing_address_page');
  }

  Widget _drawRowAddress(int index) {
    BillingAddress item = listAddress.list[index];

    return Card(
      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: ListTile(
        onTap: () {
          _editAddress(index);
        },
        title: Text(item.businessName, style: TextStyle(fontSize: 18.0)),
        subtitle: Row(
          children: <Widget>[
            Text(item.address + ' ', style: TextStyle(fontSize: 16.0)),
            Text(item.postalCode + ', ' + item.city,
                style: TextStyle(fontSize: 16.0))
          ],
        ),
        trailing: InkResponse(
          child: Icon(Icons.delete),
          onTap: () {
            _deleteAddress(index);
          },
        ),
      ),
    );
  }

  void _editAddress(int index) async {
    final id = listAddress.list[index].id;
    Navigator.pushNamed(context, 'edit_billings_page', arguments: id);
  }

  void _deleteAddress(int index) async {
    final id = listAddress.list[index].id;
    final response = await _apiBillingAddress.removeBillingAddress(id);

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
