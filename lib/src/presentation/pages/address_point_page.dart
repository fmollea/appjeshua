import 'package:appjeshua/src/presentation/pages/sucursal_page.dart';
import 'package:flutter/material.dart';

import 'list_delivery_address_page.dart';

class AddressPointPage extends StatelessWidget {
  const AddressPointPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Punto de entrega", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
            bottom: TabBar(
              tabs: [
                Tab(text: "Acude",),
                Tab(text: "Recibe"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SucursalPage(),
              ListDeliveryAddressPage()
            ],
          ),
        ),
    ));
  }
}