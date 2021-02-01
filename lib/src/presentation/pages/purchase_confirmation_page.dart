import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:flutter/material.dart';

class PurchaseConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Confirmación de compra",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: _drawScreen(context));
  }

  Widget _drawScreen(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 8),
      child: Column(
        children: <Widget>[
          Text(
            '',
            style: TextStyle(fontSize: 24),
          ),
          Center(
              child: Icon(Icons.shopping_cart,
                  color: Utils.primaryColor, size: 80)),
          Text(
            '',
            style: TextStyle(fontSize: 24),
          ),
          Center(
              child: Text('¿Estas seguro de realizar este pedido?',
                  style: TextStyle(color: Colors.black87, fontSize: 24.0),
                  textAlign: TextAlign.center)),
          Text(
            '',
            style: TextStyle(fontSize: 24),
          ),
          Card(
              child: ListTile(
                  title: Text(
                      'Es necesario que después de realizar el pago mandar el comprobante a:',
                      style: TextStyle(color: Colors.black54, fontSize: 18.0)),
                  subtitle: Text('info@farmater.com',
                      style:
                          TextStyle(color: Utils.primaryColor, fontSize: 16.0)),
                  leading: Icon(Icons.mail_outline, color: Utils.redColor))),
          Text(
            '',
            style: TextStyle(fontSize: 12),
          ),
          Card(
              child: ListTile(
                  title: Text('El pedido es recibido una vez',
                      style: TextStyle(color: Colors.black54, fontSize: 18.0)),
                  subtitle: Text('confirmes el pago',
                      style:
                          TextStyle(color: Utils.primaryColor, fontSize: 16.0)),
                  leading:
                      Icon(Icons.playlist_add_check, color: Utils.redColor))),
          Expanded(child: Text('')),
          ButtonWidget(() {
            Navigator.pushNamed(context, 'purchase_made_page');
          }, Utils.redColor, "Siguiente")
        ],
      ),
    );
  }
}
