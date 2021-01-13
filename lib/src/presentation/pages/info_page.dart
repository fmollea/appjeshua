import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Información de la app", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
      ),
      body: WebView(
        gestureRecognizers: Set()
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
            ), // or null
          ),
        key: Key("info_app"),
        javascriptMode: JavascriptMode.disabled,
        initialUrl: "https://www.farmater.com.mx/infoapp/pages/info.html")
    );
  }
}