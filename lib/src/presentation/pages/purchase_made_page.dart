import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/core/models/deliveryAddress.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/row_product_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseMadePage extends StatelessWidget {
  final _user = User();
//  final _user.deliveryAddress = DeliveryAddress();
//  final _user.billingAddress = BillingAddress();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Resumen de compra",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: _drawScreen(context),
        bottomNavigationBar: _drawBottom(context));

  }

  _drawScreen(BuildContext context) {
    return _drawContent(context);
  }

  _drawContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 8),
      child: Column(
        children: _listWidgets()
      ),
    );
  }

  _drawCardInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(children: [
                Text('Pedido ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(child: Text(_user.lastOrder, style: TextStyle(color: Utils.redColor, 
                  fontWeight: FontWeight.bold, fontSize: 20),textAlign: TextAlign.right)),
              ]
            ),
            Container(height: 8),
            Row(
              children: [
                Text('Generado: '),
                Expanded(child: 
                  Text(_user.date == null ?  _getDateFormat() : _user.date, 
                  textAlign: TextAlign.right))
              ],
            ),
            Container(height: 6),
            Row(
              children: [
                Text('Forma de pago: '),
                Expanded(child: Text(_user.payment, overflow: TextOverflow.ellipsis,
                  maxLines: 3, textAlign: TextAlign.right)),
              ],
            ),
            Container(height: 6),
            Row(
              children: [
                Text('Subtotal (${_user.cantProducts()}) '),
                Expanded(child: Text('\$ ${_user.obtainTotal()}', textAlign: TextAlign.right)),
              ],
            ),
            Container(height: 6),
            Row(children: [
              Text('    * Todos los precios incluyen IVA.', style: TextStyle(fontSize: 12),),
            ]),
            Container(height: 8),
            Row(children: [
                Text('Total ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(child: Text('\$ ${_user.obtainTotal()} MXM', style: TextStyle(color: Utils.secondaryColor, 
                  fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.right)),
              ]
            ),
          ],
        ))
    );
  }

  _drawCardDeliveryAddress() {
    _user.deliveryAddress.changeNullToEmpty();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_user.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Container(height: 8),
            Text('  ${_user.deliveryAddress.address}, ${_user.deliveryAddress.noInt}, ${_user.deliveryAddress.noExt}', style: TextStyle(fontSize: 18)),
            Text('  ${_user.deliveryAddress.colony}, ${_user.deliveryAddress.city}', style: TextStyle(fontSize: 18)),
            Text('  C.P. ${_user.deliveryAddress.postal}', style: TextStyle(fontSize: 18)),
            Container(height: 4),
            Text('  ${_user.email}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Utils.primaryColor)),
          ],
        ),
      ),
    );
  }

  _drawCardBillingInfo() {
    _user.billingAddress.changeNullToEmpty();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('  RFC: ${_user.billingAddress.rfc}', style: TextStyle(fontSize: 18))),
              ],
            ),
            Text('  ${_user.billingAddress.address}, ${_user.billingAddress.nroInt}, ${_user.billingAddress.nroExt}', style: TextStyle(fontSize: 18)),
            Text('  ${_user.billingAddress.colony}, ${_user.billingAddress.city}', style: TextStyle(fontSize: 18)),
            Text('  C.P. ${_user.billingAddress.postal}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  _drawBottom(BuildContext context) => 
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
              child: ButtonWidget(() {
          Navigator.of(context).pushNamedAndRemoveUntil(
            'main_page', ModalRoute.withName('login'));
          }, Utils.primaryColor, "Seguir Comprando"),
      ),
    );

    String _getDateFormat() => DateFormat('dd-MM-yyyy')
      .format(DateTime.now());

  _titleSection(String text) {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              Text(text, style: TextStyle(fontSize: 18, color: Utils.primaryColor, fontWeight: FontWeight.bold)),
            ])
          );
  }

  List<Widget> _listWidgets() => _listAux() + _products();

  List<Widget> _listAux() => [
    _drawCardInfo(),
    _titleSection('Enviado a: '),
    _drawCardDeliveryAddress(),
    _titleSection('Datos de facturación: '),
    _drawCardBillingInfo(),
    _titleSection('Lista de productos: '),
  ];

  List<Widget> _products() => _user.carts.map((item) => RowProductOrderWidget(item: item)).toList();
}
