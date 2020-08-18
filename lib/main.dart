import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Utils.titleApp,
      theme: ThemeData(
          /* TextTheme(
    headline1   : TextStyle(debugLabel: 'whiteMountainView display4',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
    headline2   : TextStyle(debugLabel: 'whiteMountainView display3',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
    headline3   : TextStyle(debugLabel: 'whiteMountainView display2',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
    headline4   : TextStyle(debugLabel: 'whiteMountainView display1',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
    headline5   : TextStyle(debugLabel: 'whiteMountainView headline',   fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
    headline6      : TextStyle(debugLabel: 'whiteMountainView title',      fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
    subtitle1    : TextStyle(debugLabel: 'whiteMountainView subhead',    fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
    bodyText1     : TextStyle(debugLabel: 'whiteMountainView body2',      fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
    bodyText2      : TextStyle(debugLabel: 'whiteMountainView body1',      fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
    caption    : TextStyle(debugLabel: 'whiteMountainView caption',    fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
    button     : TextStyle(debugLabel: 'whiteMountainView button',     fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
    subtitle2   : TextStyle(debugLabel: 'whiteMountainView subtitle',   fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
    overline   : TextStyle(debugLabel: 'whiteMountainView overline',   fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
  ), */
          backgroundColor: Colors.white,
          accentColor: Utils.redColor,
          primaryColor: Utils.primaryColor,
          secondaryHeaderColor: Utils.redColor),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),
    );
  }
}
