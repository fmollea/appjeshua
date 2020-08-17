import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/billingAddress.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiBillingAddress.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/text_input_widget.dart';
import 'package:flutter/material.dart';

class EditBillingPage extends StatefulWidget {
  @override
  _EditBillingPageState createState() => _EditBillingPageState();
}

class _EditBillingPageState extends State<EditBillingPage> {
  int idBillingAddress;
  BillingAddress _billingAddress;
  TextEditingController address = TextEditingController();
  TextEditingController bussinesName = TextEditingController();
  TextEditingController noInterior = TextEditingController();
  TextEditingController noExterior = TextEditingController();
  TextEditingController cdgPostal = TextEditingController();
  TextEditingController rfc = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    idBillingAddress = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
          title: Text("Editar dirección de facturación",
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
    final api = ApiBillingAddress();

    return FutureBuilder(
      future: api.showBillingAddress(idBillingAddress),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _billingAddress = snapshot.data;
          setValuesInTextField();
          return SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _textFieldName(),
              _textFieldRfc(),
              _textFieldAddress(),
              _textFieldNroInterior(),
              _textFieldNroExterior(),
              _textFieldCodigoPostal(),
              _textFieldCity(),
            ],
          ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buttonRegister() {
    return Padding(
        padding: EdgeInsets.all(18.0),
        child:
            ButtonWidget(editAddress, Utils.primaryColor, 'Editar dirección'));
  }

  Widget _textFieldName() {
    return TextInputWidget(
      text: "Nombre",
      controller: bussinesName,
      isPass: false,
      type: TextInputType.text,
    );
  }

  Widget _textFieldRfc() {
    return TextInputWidget(
      text: "RFC",
      controller: rfc,
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
      type: TextInputType.text,
    );
  }

  Widget _textFieldNroExterior() {
    return TextInputWidget(
      text: "No. Exterior",
      controller: noExterior,
      isPass: false,
      type: TextInputType.text,
    );
  }

  Widget _textFieldCodigoPostal() {
    return TextInputWidget(
      text: "Código Postal",
      controller: cdgPostal,
      isPass: false,
      type: TextInputType.text,
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

  void editAddress() async {
    if (checksFields()) {
      final api = ApiBillingAddress();
      ResponseDto responseDto = await api.updateBillingAddress(
          idBillingAddress,
          rfc.text,
          bussinesName.text,
          '1',
          address.text,
          city.text,
          cdgPostal.text,
          noExterior.text,
          noInterior.text,
          '1');

      if (NetworkUtils.isReqSuccess(responseDto.code)) {
        Utils.showToast(
            "Dirección modificada correctamente.", Colors.white, Colors.green);
        _emptyFields();
        setState(() {});
      } else {
        Utils.showToast(
            "No se pudo editar la dirección.", Colors.white, Colors.red);
      }
    } else {
      Utils.showToast(
          "Debe completar todos los campos para editar la dirección.",
          Colors.white,
          Colors.red);
    }
  }

  bool checksFields() {
    return bussinesName.text != "" &&
        rfc.text != "" &&
        address.text != "" &&
        cdgPostal.text != "" &&
        city.text != "" &&
        noInterior.text != "" &&
        noExterior.text != "";
  }

  void _emptyFields() {
    address.text = "";
    rfc.text = "";
    bussinesName.text = "";
    noInterior.text = "";
    noExterior.text = "";
    cdgPostal.text = "";
    city.text = "";
  }

  setValuesInTextField() {
    bussinesName.text = _billingAddress.businessName;
    rfc.text = _billingAddress.rfc;
    address.text = _billingAddress.address;
    cdgPostal.text = _billingAddress.postalCode;
    city.text = _billingAddress.city;
    noInterior.text = _billingAddress.inside;
    noExterior.text = _billingAddress.outside;
  }
}
