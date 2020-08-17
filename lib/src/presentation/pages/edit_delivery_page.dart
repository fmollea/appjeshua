import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/deliveryAddress.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiDeliveryAddress.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/text_input_widget.dart';
import 'package:flutter/material.dart';

class EditDeliveryPage extends StatefulWidget {
  @override
  _EditDeliveryPageState createState() => _EditDeliveryPageState();
}

class _EditDeliveryPageState extends State<EditDeliveryPage> {
  int idDeliveyAddress;
  DeliveryAddress _deliveryAddress;
  TextEditingController address = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cdgPostal = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    idDeliveyAddress = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text("Editar dirección de envío",
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
    final api = ApiDeliveryAddress();

    return FutureBuilder(
      future: api.showDeliveryAddress(idDeliveyAddress),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _deliveryAddress = snapshot.data;
          setValuesInTextField();
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

  void editAddress() async {
    if (checksFields()) {
      final api = ApiDeliveryAddress();
      ResponseDto responseDto = await api.updateDeliveryAddress(
          idDeliveyAddress,
          name.text,
          "1",
          address.text,
          city.text,
          cdgPostal.text,
          "1");

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
    return name.text != "" &&
        address.text != "" &&
        cdgPostal.text != "" &&
        city.text != "";
  }

  void _emptyFields() {
    setState(() {
      address.text = "";
      name.text = "";
      cdgPostal.text = "";
      city.text = "";
    });
  }

  setValuesInTextField() {
    name.text = _deliveryAddress.name;
    address.text = _deliveryAddress.address;
    cdgPostal.text = _deliveryAddress.postalCode;
    city.text = _deliveryAddress.city;
  }
}
