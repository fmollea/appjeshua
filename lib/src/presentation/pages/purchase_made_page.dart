import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/services/apiPayments.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:flutter/material.dart';

class PurchaseMadePage extends StatelessWidget {
  final _apiPayment = ApiPayments();

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

  _drawScreen(BuildContext context) {
    return FutureBuilder(
      future: _apiPayment.processPayment(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return _drawContent(context);
      },
    );
  }

  _drawContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 8),
      child: Column(
        children: <Widget>[
          Text(
            '',
            style: TextStyle(fontSize: 24),
          ),
          Center(
              child: Icon(Icons.check_circle_outline,
                  color: Utils.primaryColor, size: 80)),
          Text(
            '',
            style: TextStyle(fontSize: 24),
          ),
          Center(
              child: Text('¡Gracias por tu compra!',
                  style: TextStyle(color: Utils.redColor, fontSize: 24.0),
                  textAlign: TextAlign.center)),
          Text(
            '',
            style: TextStyle(fontSize: 12),
          ),
          Center(
              child: Text('',
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  textAlign: TextAlign.center)),
          Text(
            '',
            style: TextStyle(fontSize: 24),
          ),
          Text(
              'Tu pedido se ha recibido y se está procesando. Recibirá un email con los detalles de su compra',
              style: TextStyle(color: Colors.black54, fontSize: 18),
              textAlign: TextAlign.center),
          Expanded(child: Text('')),
          ButtonWidget(() {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'main_page', ModalRoute.withName('login'));
          }, Utils.primaryColor, "Seguir comprando")
        ],
      ),
    );
  }
}
