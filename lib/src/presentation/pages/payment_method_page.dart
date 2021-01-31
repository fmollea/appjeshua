import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/paymentMethod.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiPayments.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/content_dialog.dart';
import 'package:appjeshua/src/presentation/widget/milestone_widget.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final _apiPayment = ApiPayments();
  PaymentMethods _listPaymentMethods = PaymentMethods();
  User user = User();
  var response;
  int isSelected = 0;

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
                  MilestoneWidget(actual: 3),
                  _drawListPaymentMethods(),
                  _drawBottom()
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
    Navigator.pushNamed(context, 'purchase_made_page');
  }

  void navToInit() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('main_page', ModalRoute.withName('login'));
  }

  processPayment() async {
    ApiPayments api = ApiPayments();
    if (response == null) {
      Utils.showLoading(context);
      response = await api.processPayment();
      setState(() {
        processPaymentAux();
      });
    } else {
      Utils.hideLoading(context);
      showDialogConfirm();
    }
  } 

  // ver como dejar todo en un solo método. El problema es que se llama dos veces la llamada a la API.
  processPaymentAux() {
    if (response == null) {
      Utils.showLoading(context);
      setState(() {
        processPaymentAux();
      });
    } else {
      Utils.hideLoading(context);
      showDialogConfirm();
    }
  }

  void showDialogConfirm() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: ContentDialog(
              pathImg: 'assets/icon_gracias.png',
              title: '¡Gracias!',
              subtitle: 'Su pedido está en proceso',
              textPrimaryAction: 'Seguir Comprando',
              primaryAction: navToInit,
              textSecondaryAction: 'VER RESUMEN DE COMPRA',
              secondaryAction: navToPage,
            ),
          );
        });
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
              leading: Icon(Icons.add_circle_outline, color: Utils.secondaryColor),
              title: Text("Método de pago no disponible",
                  style: TextStyle(color: Colors.black87, fontSize: 18.0)),
              subtitle: Text(
                  "Ocurrió un error o no hay métodos de pago disponibles. Comuníquese con la sucursal "
                  "más cercana",
                  style: TextStyle(color: Colors.black54, fontSize: 16.0)),
            ))));
  }

  Widget _drawListPaymentMethods() {
    if (isSelected == 0) {
      user.paymentId = _listPaymentMethods.list[0].id;
      user.payment = _listPaymentMethods.list[0].name;
    }
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _listPaymentMethods.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _drawRowPaymentMethod(index);
            }));
  }

  Widget _drawRowPaymentMethod(int index) {
    User user = User();
    PaymentMethod item = _listPaymentMethods.list[index];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Radio(
                groupValue: index,
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    final item = _listPaymentMethods.list[index];
                    user.paymentId = item.id;
                    user.payment = item.name;
                    item.isSelected = !item.isSelected;
                    isSelected = index;

                    if (item.isSelected) {
                      user.paymentId = item.id;
                      user.payment = item.name;
                    }
                  });
                }),
            Expanded(child: Text(item.name, style: TextStyle(fontSize: 16.0))),
          ],
        ),
      ),
    );
  }

  Widget _drawBottom() {
    return Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
            child: ButtonWidget(
                processPayment, Utils.primaryColor, "Finalizar compra"));
  }
}