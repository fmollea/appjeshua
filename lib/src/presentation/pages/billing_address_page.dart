import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/content_billing_address.dart';
import 'package:appjeshua/src/presentation/widget/milestone_widget.dart';
import 'package:flutter/material.dart';

class BillingAddressPage extends StatefulWidget {
  @override
  _BillingAddressPageState createState() => _BillingAddressPageState();
}

class _BillingAddressPageState extends State<BillingAddressPage> {
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController colony = TextEditingController();
  TextEditingController noInterior = TextEditingController();
  TextEditingController noExterior = TextEditingController();
  TextEditingController cdgPostal = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController razon = TextEditingController();
  TextEditingController rfc = TextEditingController();
  TextEditingController type = TextEditingController();
  bool ticket = false;

  var address = BillingAddress();

  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Datos de facturación",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: _drawScreen(),
        bottomNavigationBar: _drawBottom());
  }

  Widget _drawScreen() {
    return Padding(
      padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 8),
      child: ListView(
        children: [
          MilestoneWidget(actual: 2),
          ContentBillingAddress(
            street: street,
            city: city,
            colony: colony,
            noInterior: noInterior,
            noExterior: noExterior,
            cdgPostal: cdgPostal,
            state: state,
            razon: razon,
            rfc: rfc,
            type: type,
          ),
          Container(height: 8),
          Row(
            children: [
              Checkbox(
                value: ticket,
                onChanged: _changesValue
              ),
              Text('Solicito factura electrónica')
            ],
          )
        ],
      ),
    );    
  }

  void navToPage() {
    saveAddress();
    Navigator.pushNamed(context, 'payment_method_page');
  }

  Widget _drawBottom() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
          child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 24),
              color: Colors.white,
              child: ButtonWidget(navToPage, Utils.primaryColor, "Continuar"))),
    );
  }

  saveAddress() {
    address.street = street.text;
    address.city = city.text;
    address.colony = colony.text;
    address.country = "Mexico";
    address.inside = noInterior.text;
    address.outside = noExterior.text;
    address.postal = cdgPostal.text;
    address.razon = razon.text;
    address.rfc = rfc.text;
    address.state = state.text;
    address.type = type.text;
    address.ticket = ticket;
  }

  loadAddress() {
    street.text = address.street;
    city.text = address.city;
    colony.text = address.colony;
    noInterior.text = address.inside;
    noExterior.text = address.outside;
    cdgPostal.text = address.postal;
    razon.text = address.razon;
    rfc.text = address.rfc;
    state.text = address.state;
    type.text = address.type;
  }

  void _changesValue(bool newValue) => setState(() {
    ticket = newValue;
  });
}
