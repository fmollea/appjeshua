import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  //Strings
  static final String titleApp = "App Jeshua";

  static final String titleRegister = "Registro de usuarios";
  static final String titleForgetPass = "Recuperar contraseña";
  static final String titleMarket = "Productos!";
  static final String titleForgotPass = "Recuperar contraseña";
  static final String titleProfile = "Mi cuenta";
  static final String titleContact = "Ayuda";

  //Colors
  static final Color primaryColor = Color.fromRGBO(0, 65, 130, 1);
  static final Color secondaryColor = Color(0xFF476bb2);
  static final Color redColor = Color.fromRGBO(227, 42, 37, 1);
  static final Color iconBottomColor = Color.fromRGBO(0, 242, 255, 1);
  static final Color textDarkColor = Colors.black87;

  static final String path1 = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fassets.pokemon.com%2Fassets%2Fcms2%2Fimg%2Fpokedex%2Ffull%2F006.png&imgrefurl=https%3A%2F%2Fwww.pokemon.com%2Fes%2Fpokedex%2Fcharizard&tbnid=xl2wn-641bZMzM&vet=10CBQQxiAoAmoXChMIwLn68fnu7QIVAAAAAB0AAAAAEAo..i&docid=J82tE9FLOV9jyM&w=475&h=475&itg=1&q=charmander&ved=0CBQQxiAoAmoXChMIwLn68fnu7QIVAAAAAB0AAAAAEAo";
  static final String placeHolderPath = "assets/not_found.png";
  static String getPerfilImage(String path, int id) => "https://jeshuamedic.com/4dministraci0n/public/img/user/$id/$path";
  static String getCategoryImage(String path) => "https://app.jeshuamedic.com/assets/images/icons/$path";
  static String getProductImage(String path, int id) => "https://jeshuamedic.com/4dministraci0n/public/img/products/$id/$path";
  static String urlCellphone() => 'tel:7151530231';

  //maps of icons
  final _icons = <String, IconData>{
    'products': FlutterIcons.pill_mco,
    'category': Icons.list,
    'cart': Icons.shopping_cart,
    'history': Icons.search,
    'help': Icons.help_outline,
    'log_out': Icons.lock_outline,
    'shipping_address': Icons.location_on,
    'billing_address': Icons.library_books,
    'person': Icons.person_outline,
    'password': Icons.lock_outline,
    'not_fav': Icons.favorite_border,
    'is_fav': Icons.favorite,
    'notification': Icons.notifications_none
  };

  Icon getIcon(String iconName, Color colorIcon) {
    return Icon(_icons[iconName], color: colorIcon);
  }

  static showToast(String message, Color textColor, Color background) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: background,
        textColor: textColor,
        fontSize: 16.0);
  }

  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
                onWillPop: () async => false,
                child: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
            )),
          );
        });
  }

  static void hideLoading(BuildContext context) => Navigator.pop(context);
}
