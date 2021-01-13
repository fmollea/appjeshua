import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Contactos", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
      ),
      body: WebView(
        gestureRecognizers: Set()
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
            ), // or null
          ),
        key: Key("contact"),
        javascriptMode: JavascriptMode.disabled,
        initialUrl: "https://www.farmater.com.mx/infoapp/pages/contact_us.html")
    );
  }
}