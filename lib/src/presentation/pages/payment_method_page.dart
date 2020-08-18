import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/paymentMethod.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiPayments.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final _apiPayment = ApiPayments();
  PaymentMethods _listPaymentMethods = PaymentMethods();
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Método de pago",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: _drawScreen());
  }

  Widget _drawScreen() {
    return FutureBuilder(
      future: _apiPayment.listPaymentMethods(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (_listPaymentMethods.list.isEmpty ||
              _listPaymentMethods.list == null) {
            _listPaymentMethods = snapshot.data;
          }

          if (_listPaymentMethods.list.isEmpty) {
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
    if (checkSelected())
      Navigator.pushNamed(context, 'purchase_confirmation_page');
    else
      Utils.showToast("Seleccione el método de pago que desea usar.",
          Colors.white, Colors.red);
  }

  bool checkSelected() {
    bool check = false;
    _listPaymentMethods.list.forEach((element) {
      if (element.isSelected) check = true;
    });

    return check;
  }

  Widget emptyState() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Card(
                child: ListTile(
              leading: Icon(Icons.add_circle_outline, color: Utils.redColor),
              title: Text("Método de pago no disponible",
                  style: TextStyle(color: Colors.black87, fontSize: 18.0)),
              subtitle: Text(
                  "Ocurrió un error o no hay métodos de pago disponibles. Comuníquese con la sucursal "
                  "más cercana",
                  style: TextStyle(color: Colors.black54, fontSize: 16.0)),
            ))));
  }

  Widget _drawListAddress() {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _listPaymentMethods.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _drawRowAddress(index);
            }));
  }

  Widget _drawRowAddress(int index) {
    PaymentMethod item = _listPaymentMethods.list[index];
    Icon icon;

    if (item.isSelected) {
      icon = Icon(Icons.check_circle_outline, color: Utils.redColor);
      user.paymentId = item.id;
    } else {
      icon = Icon(Icons.radio_button_unchecked, color: Colors.grey);
    }

    return Card(
      child: ListTile(
        onTap: () {
          _selectedAddress(index);
        },
        title: Text(item.name, style: TextStyle(fontSize: 18.0)),
        subtitle: Text(item.description, style: TextStyle(fontSize: 16.0)),
        leading: icon,
      ),
    );
  }

  void _selectedAddress(int index) async {
    PaymentMethod item = _listPaymentMethods.list[index];

    _listPaymentMethods.list.forEach((element) {
      if (element != item) element.isSelected = false;
    });

    item.isSelected = !item.isSelected;
    setState(() {
      _drawRowAddress(index);
    });
  }
}
