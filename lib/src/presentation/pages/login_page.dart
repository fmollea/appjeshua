import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/presentation/pagesviews/login_page_view.dart';
import 'package:appjeshua/src/presentation/presenters/login_presenter.dart';
import 'package:appjeshua/src/presentation/widget/alert_widget.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageView {
  FocusNode emailFocus = new FocusNode();
  FocusNode passFocus = new FocusNode();
  final utils = Utils();
  bool _isObscureText = true;

  LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter();
    _presenter.attachView(this);
    _presenter.obtainSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('', style: TextStyle(fontSize: 48.0)),
          _imageLogo(),
          _textFieldUsername(),
          _textFieldPassword(),
          Text('', style: TextStyle(fontSize: 48.0)),
          Text('', style: TextStyle(fontSize: 16.0)),
          _buttonLogin(),
          Text('', style: TextStyle(fontSize: 16.0)),
          _textForgetYourPassword(),
        ],
      ),
    );
  }

  Widget _imageLogo() {
    return Container(
      padding: EdgeInsets.all(16),
      width: 250,
      height: 250,
      child: Image(
        image: AssetImage('assets/logologin.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textFieldUsername() {
    return TextField(
      focusNode: emailFocus,
      controller:  _presenter.name,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Usuario',
          labelStyle: TextStyle(color: Utils.primaryColor),
          prefixIcon: utils.getIcon('person', Utils.redColor))
    );
  }

  Widget _textFieldPassword() {
    return TextField(
      focusNode: passFocus,
      controller: _presenter.password,
      obscureText: _isObscureText,
      decoration: InputDecoration(
          labelText: 'Contraseña',
          labelStyle: TextStyle(color: Utils.primaryColor),
          suffixIcon: _buildPasswordIcon(),
          prefixIcon: utils.getIcon('password', Utils.redColor))
    );
  }

  Widget _buttonLogin() {
    return ButtonWidget(() {
      _presenter.loginUser('main_page');
    }, Utils.primaryColor, 'Entrar');
  }

  Widget _textForgetYourPassword() {
    return InkResponse(
      child: Text('¿Olvidaste tu contraseña?',
          style: TextStyle(color: Utils.redColor, fontSize: 16.0)),
      onTap: () {
        _presenter.navToPage('forget_pass_page');
      },
    );
  }

  @override
  navToPage(String path) {
    Navigator.pushNamedAndRemoveUntil(context, path, ModalRoute.withName(path));
  }

  @override
  showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          ));
        });
  }

  @override
  hideLoading() {
    Navigator.pop(context);
  }

  @override
  showAlertDialog(String title, String content) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertWidget(title: title, content: content);
        });
  }

  Widget _buildPasswordIcon() {
    var iconData =
        _isObscureText ? FlutterIcons.eye_off_mco : FlutterIcons.eye_mco;
    return IconButton(
      onPressed: () {
        setState(() {
          _isObscureText = !_isObscureText;
        });
      },
      icon: Icon(
        iconData,
        color: Utils.primaryColor,
      ),
    );
  }
}
