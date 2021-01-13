import 'package:appjeshua/src/presentation/widget/text_input_widget.dart';
import 'package:flutter/material.dart';

class ContentDeliveryAddress extends StatelessWidget {
  final TextEditingController street;
  final TextEditingController city;
  final TextEditingController colony;
  final TextEditingController noInterior;
  final TextEditingController noExterior;
  final TextEditingController cdgPostal;
  final TextEditingController state;

  const ContentDeliveryAddress({Key key, this.street, this.colony, this.noInterior, this.noExterior, this.cdgPostal, this.city, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return drawView();
  }

  Widget drawView() {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _textFieldStreet(),
        _textFieldNroInterior(),
        _textFieldNroExterior(),
        _textFieldColony(),
        _textFieldCity(),
        _textFieldCodigoPostal(),
        _textFieldState(),
      ],
    ));
  }

  bool obtainIsEnabled(TextEditingController controller) => false;

  Widget _textFieldStreet() {
    return TextInputWidget(
      text: "Calle",
      controller: street,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(street),
    );
  }

  Widget _textFieldCity() {
    return TextInputWidget(
      text: "Ciudad",
      controller: city,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(city),
    );
  }

  Widget _textFieldColony() {
    return TextInputWidget(
      text: "Colonia",
      controller: colony,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(colony),
    );
  }

  Widget _textFieldNroInterior() {
    return TextInputWidget(
      text: "No. Interior",
      controller: noInterior,
      isPass: false,
      type: TextInputType.number,
      isEnabled: obtainIsEnabled(noInterior),
    );
  }

  Widget _textFieldNroExterior() {
    return TextInputWidget(
      text: "No. Exterior",
      controller: noExterior,
      isPass: false,
      type: TextInputType.number,
      isEnabled: obtainIsEnabled(noExterior),
    );
  }

  Widget _textFieldCodigoPostal() {
    return TextInputWidget(
      text: "Código Postal",
      controller: cdgPostal,
      isPass: false,
      type: TextInputType.number,
      isEnabled: obtainIsEnabled(cdgPostal),
    );
  }

  Widget _textFieldState() {
    return TextInputWidget(
      text: "Estado",
      controller: state,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(state),
    );
  }
}