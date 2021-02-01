import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiUser.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/text_input_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(Utils.titleForgetPass,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold))),
        body: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 24),
          child: drawView(),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 24, right: 24),
            child: _buttonRegister()));
  }

  Widget _textFieldEmail() {
    return TextInputWidget(
      text: "Email",
      controller: _email,
      isPass: false,
      type: TextInputType.emailAddress,
    );
  }

  Widget _buttonRegister() {
    return ButtonWidget(
        forgetPassword, Utils.redColor, 'Cambiar contraseña');
  }

  forgetPassword() async {
    ApiUser api = ApiUser();

    if (_email != null && _email.text.isNotEmpty) {
      ResponseDto response = await api.forgetPassword(_email.text);

      if (NetworkUtils.isReqSuccess(response.code)) {
        Utils.showToast("Te enviamos un email con las intrucciones a seguir.",
            Colors.white, Colors.green);
      } else {
        Utils.showToast("Ocurrió un error, por favor vuelve a intentarlo.",
            Colors.white, Colors.red);
      }
    } else {
      Utils.showToast(
          "Ingrese la direccíon de su correo electrónico para poder restablecer su contraseña.",
          Colors.white,
          Colors.red);
    }
  }

  drawView() {
    return Column(children: <Widget>[
      Text(
          'Por favor introduce la dirección de correo electrónico de tu cuenta, te enviaremos instrucciones'
          'sobre como restablecer tu contraseña',
          style: TextStyle(color: Colors.black54, fontSize: 18),
          textAlign: TextAlign.center),
      _textFieldEmail(),
    ]);
  }
}
