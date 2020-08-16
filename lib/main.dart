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
