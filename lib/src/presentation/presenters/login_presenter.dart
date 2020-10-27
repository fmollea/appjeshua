import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/core/models/loginDto.dart';
import 'package:appjeshua/src/core/services/apiLogin.dart';
import 'package:appjeshua/src/presentation/pagesviews/login_page_view.dart';
import 'package:appjeshua/src/presentation/presenters/base_presenter.dart';

class LoginPresenter extends BasePresenter<LoginPageView> {
  ApiLogin _apiLogin = ApiLogin();
  String name = "";
  String password = "";

  navToPage(String path) {
    if (isViewAttached) {
      getView().navToPage(path);
    }
  }

  loginUser(String path) async {
    if (isViewAttached) {
      getView().showLoading();
      LoginDto _loginDto = await _apiLogin.postLogin(name, password);
      if (NetworkUtils.isReqSuccess(_loginDto.code)) {
        await onSuccessLogin(path);
      } else {
        onFailLogin();
      }
    }
  }

  onSuccessLogin(String path) async {
    if (isViewAttached) {
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
