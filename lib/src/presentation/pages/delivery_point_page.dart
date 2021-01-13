import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/deliveryAddress.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/content_delivery_address.dart';
import 'package:appjeshua/src/presentation/widget/milestone_widget.dart';
import 'package:flutter/material.dart';

class DeliveryPointPage extends StatefulWidget {
  @override
  _DeliveryPointPageState createState() => _DeliveryPointPageState();
}

class _DeliveryPointPageState extends State<DeliveryPointPage> {
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController colony = TextEditingController();
  TextEditingController noInterior = TextEditingController();
  TextEditingController noExterior = TextEditingController();
  TextEditingController cdgPostal = TextEditingController();
  TextEditingController state = TextEditingController();

  var address = DeliveryAddress();

  @override
  void initState() { 
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dirección de envío",
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
        children: <Widget>[
          MilestoneWidget(actual: 1),
          ContentDeliveryAddress(
            street: street,
            city: city,
            colony: colony,
            noInterior: noInterior,
            noExterior: noExterior,
            cdgPostal: cdgPostal,
            state: state
          ),
        ],
      ),
    );
      
  }

  void navToPage() {
    Navigator.pushNamed(context, 'billing_address_page');
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
    address.state = state.text;
  }

  loadData() {
    street.text = address.street;
    city.text = address.city;
    colony.text = address.colony;
    noInterior.text = address.inside;
    noExterior.text = address.outside;
    cdgPostal.text = address.postal;
    state.text = address.state;
  }
}
