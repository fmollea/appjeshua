import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiBillingAddress.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:flutter/material.dart';

class BillingAddressPage extends StatefulWidget {
  @override
  _BillingAddressPageState createState() => _BillingAddressPageState();
}

class _BillingAddressPageState extends State<BillingAddressPage> {
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
              child: Column(
                children: <Widget>[
                  _drawListAddress(),
                  ButtonWidget(navToPage, Utils.primaryColor, "Siguiente"),
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

  void navToPage() {
    Navigator.pushNamed(context, 'payment_method_page');
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
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: listAddress.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _drawRowAddress(index);
            }));
  }

  void addAddress() {
    Navigator.pushNamed(context, 'add_billing_address_page');
  }

  Widget _drawRowAddress(int index) {
    BillingAddress item = listAddress.list[index];
    Icon icon;

    if (item.isDefault != 0) {
      icon = Icon(Icons.speaker_notes, color: Utils.primaryColor);
      user.billingId = item.id;
    } else {
      icon = Icon(Icons.speaker_notes_off, color: Colors.grey);
    }

    return Card(
      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: ListTile(
        onTap: () {
          _selectedAddress(index);
        },
        title: Text(item.businessName, style: TextStyle(fontSize: 18.0)),
        subtitle: Row(
          children: <Widget>[
            Text(item.address + ' ', style: TextStyle(fontSize: 16.0)),
            Text(item.postalCode + ', ' + item.city,
                style: TextStyle(fontSize: 16.0))
          ],
        ),
        leading: icon,
      ),
    );
  }

  void _selectedAddress(int index) async {
    final id = listAddress.list[index].id;
    ResponseDto responseDto =
        await _apiBillingAddress.defaultBillingAddress(id);

    if (NetworkUtils.isReqSuccess(responseDto.code)) {
      setState(() {
        _drawRowAddress(index);
      });
    }
  }
}
