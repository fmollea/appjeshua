import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/milestone_widget.dart';
import 'package:flutter/material.dart'; 

class SucursalPage extends StatelessWidget {

  final User user = User();
  
  SucursalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _drawCard(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ButtonWidget(() {
          navToPage(context);
        }, Utils.redColor, "Siguiente"),
      ),
    );
  }

  _drawCard() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          MilestoneWidget(actual: 1),
          Container(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset("assets/icon_tienda.png"),
                title: Text(user.sucursalName),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navToPage(BuildContext context) {
    user.typeShipping = "acude";
    user.deliveryId = user.idSucursal;
    Navigator.pushNamed(context, 'list_billing_address_page');
  }
}