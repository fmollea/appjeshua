import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  //Strings
  static final String titleApp = "WHERE HOUSE LIFT";

  static final String titleRegister = "Registro de usuarios";
  static final String titleForgetPass = "Recuperar contraseña";
  static final String titleMarket = "Productos!";
  static final String titleForgotPass = "Recuperar contraseña";
  static final String titleProfile = "Mi cuenta";
  static final String titleContact = "Ayuda";

  static final String placeHolderPath = "";

  //Colors
  static final Color primaryColor = Color.fromRGBO(0, 65, 130, 1);
  static final Color redColor = Color.fromRGBO(227, 42, 37, 1);
  static final Color iconBottomColor = Color.fromRGBO(0, 242, 255, 1);
  static final Color textDarkColor = Colors.black87;

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
    'is_fav': Icons.favorite
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
}
