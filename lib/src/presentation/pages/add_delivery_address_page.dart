import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiDeliveryAddress.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/text_input_widget.dart';
import 'package:flutter/material.dart';

class AddDeliveryAddressPage extends StatefulWidget {
  @override
  _AddDeliveryAddressPageState createState() => _AddDeliveryAddressPageState();
}

class _AddDeliveryAddressPageState extends State<AddDeliveryAddressPage> {
  TextEditingController address = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController noInterior = TextEditingController();
  TextEditingController noExterior = TextEditingController();
  TextEditingController cdgPostal = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text("Crear dirección de envío",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold))),
      body: Container(
        padding: EdgeInsets.all(22.0),
        child: drawView(),
      ),
      bottomNavigationBar: _buttonRegister(),
    );
  }

  Widget drawView() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _textFieldName(),
          _textFieldAddress(),
          _textFieldCodigoPostal(),
          _textFieldCity()
        ],
      ),
    );
  }

  Widget _buttonRegister() {
    return Padding(
        padding: EdgeInsets.all(18.0),
        child:
            ButtonWidget(saveAddress, Utils.primaryColor, 'Guardar Dirección'));
  }

  Widget _textFieldName() {
    return TextInputWidget(
      text: "Nombre",
      controller: name,
      isPass: false,
      type: TextInputType.text,
    );
  }

  Widget _textFieldAddress() {
    return TextInputWidget(
      text: "Calle",
      controller: address,
      isPass: false,
      type: TextInputType.text,
    );
  }

  Widget _textFieldNroInterior() {
    return TextInputWidget(
      text: "No. Interior",
      controller: noInterior,
      isPass: false,
      type: TextInputType.number,
    );
  }

  Widget _textFieldNroExterior() {
    return TextInputWidget(
      text: "No. Exterior",
      controller: noExterior,
      isPass: false,
      type: TextInputType.number,
    );
  }

  Widget _textFieldCodigoPostal() {
    return TextInputWidget(
      text: "Código Postal",
      controller: cdgPostal,
      isPass: false,
      type: TextInputType.number,
    );
  }

  Widget _textFieldCity() {
    return TextInputWidget(
      text: "Ciudad",
      controller: city,
      isPass: false,
      type: TextInputType.text,
    );
  }

  void saveAddress() async {
    if (checksFields()) {
      final api = ApiDeliveryAddress();
      ResponseDto responseDto = await api.addDeliveryAddress(
          name.text, "1", address.text, city.text, cdgPostal.text, "1");

      if (NetworkUtils.isReqSuccess(responseDto.code)) {
        Utils.showToast(
            "Dirección creada correctamente.", Colors.white, Colors.green);
        _emptyFields();
      } else {
        Utils.showToast(
            "No se pudo crear la dirección.", Colors.white, Colors.red);
      }
    } else {
      Utils.showToast(
          "Debe completar todos los campos para crear una nueva dirección.",
          Colors.white,
          Colors.red);
    }
  }

  bool checksFields() {
    return name.text != "" &&
        address.text != "" &&
        cdgPostal.text != "" &&
        city.text != "";
  }

  void _emptyFields() {
    setState(() {
      address.text = "";
      name.text = "";
      noInterior.text = "";
      noExterior.text = "";
      cdgPostal.text = "";
      city.text = "";
    });
  }
}
