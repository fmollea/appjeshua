import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/core/models/loginDto.dart';
import 'package:appjeshua/src/core/services/apiCart.dart';
import 'package:appjeshua/src/core/services/apiLogin.dart';
import 'package:appjeshua/src/presentation/pagesviews/login_page_view.dart';
import 'package:appjeshua/src/presentation/presenters/base_presenter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPresenter extends BasePresenter<LoginPageView> {
  ApiLogin _apiLogin = ApiLogin();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  navToPage(String path) {
    if (isViewAttached) {
      getView().navToPage(path);
    }
  }

  obtainSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.text = prefs.getString('name') ?? "";
    password.text = prefs.getString('password') ?? "";

    if (name.text.isNotEmpty && password.text.isNotEmpty) {
      loginUser('main_page');
    }
  }

  loginUser(String path) async {
    if (isViewAttached) {
      getView().showLoading();
      LoginDto _loginDto = await _apiLogin.postLogin(name.text, password.text);
      if (NetworkUtils.isReqSuccess(_loginDto.code)) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', name.text);
        prefs.setString('password', password.text);
        await onSuccessLogin(path);
      } else {
        onFailLogin();
      }
    }
  }

  onSuccessLogin(String path) async {
    if (isViewAttached) {
      var apiCart = ApiCart();
      await apiCart.getProductsCart();
      getView().hideLoading();
      navToPage(path);
    }
  }

  onFailLogin() {
    if (isViewAttached) {
      getView().hideLoading();
      getView().showAlertDialog('Error al ingresar',
          'El email o la contraseña ingresados no son correctos.');
    }
  }
}
