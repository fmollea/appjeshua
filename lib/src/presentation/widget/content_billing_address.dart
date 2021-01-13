import 'package:appjeshua/src/presentation/widget/text_input_widget.dart';
import 'package:flutter/material.dart';

class ContentBillingAddress extends StatefulWidget {

  final TextEditingController street;
  final TextEditingController city;
  final TextEditingController colony;
  final TextEditingController noInterior;
  final TextEditingController noExterior;
  final TextEditingController cdgPostal;
  final TextEditingController state;
  final TextEditingController razon;
  final TextEditingController rfc;
  final TextEditingController type;

  ContentBillingAddress({Key key, this.street, this.colony, this.noInterior, this.noExterior, 
    this.cdgPostal, this.rfc, this.city, this.razon, this.type, this.state}) : super(key: key);

  @override
  _ContentBillingAddressState createState() => _ContentBillingAddressState();
}

class _ContentBillingAddressState extends State<ContentBillingAddress> {
  List<String> _listType = ['Persona Física', 'Persona Moral'];
  String _tipeSelected = 'Persona Física';
  
  @override
  void initState() {
    super.initState();
    widget.type.text = _tipeSelected;
  }

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
        _textFieldType(),
        _textFieldRfc(),
        _textFieldRazon(),
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

  bool obtainIsEnabled(TextEditingController controller) => 
    controller.text == null || controller.text.isEmpty; 

  Widget _textFieldStreet() {
    return TextInputWidget(
      text: "Calle",
      controller: widget.street,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(widget.street),
    );
  }

  Widget _textFieldRfc() {
    return TextInputWidget(
      text: "RFC",
      controller: widget.rfc,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(widget.rfc),
    );
  }

  Widget _textFieldType() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(            
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DropdownButton(
          style: TextStyle(color: Colors.black87, fontSize: 16),
          isExpanded: true,
          value:  _tipeSelected,
          items: _listType.map((type) {
            return DropdownMenuItem(
              child: new Text(type),
              value: type,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _tipeSelected = value;
              widget.type.text = value;
            });
          }),
      ),
    );
  }

  Widget _textFieldNroInterior() {
    return TextInputWidget(
      text: "No. Interior",
      controller: widget.noInterior,
      isPass: false,
      type: TextInputType.number,
      isEnabled: obtainIsEnabled(widget.noInterior),
    );
  }

  Widget _textFieldNroExterior() {
    return TextInputWidget(
      text: "No. Exterior",
      controller: widget.noExterior,
      isPass: false,
      type: TextInputType.number,
      isEnabled: obtainIsEnabled(widget.noExterior),
    );
  }

  Widget _textFieldCodigoPostal() {
    return TextInputWidget(
      text: "Código Postal",
      controller: widget.cdgPostal,
      isPass: false,
      type: TextInputType.number,
      isEnabled: obtainIsEnabled(widget.cdgPostal),
    );
  }

  Widget _textFieldCity() {
    return TextInputWidget(
      text: "Ciudad",
      controller: widget.city,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(widget.city),
    );
  }

  Widget _textFieldColony() {
    return TextInputWidget(
      text: "Colonia",
      controller: widget.colony,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(widget.colony),
    );
  }

  Widget _textFieldState() {
    return TextInputWidget(
      text: "Estado",
      controller: widget.state,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(widget.state),
    );
  }

  Widget _textFieldRazon() {
    return TextInputWidget(
      text: "Razón Social",
      controller: widget.razon,
      isPass: false,
      type: TextInputType.text,
      isEnabled: obtainIsEnabled(widget.razon),
    );
  }
}