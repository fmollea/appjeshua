import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FrequentQuetionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Preguntas frecuentes", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
      ),
      body: WebView(
        gestureRecognizers: Set()
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
            ), // or null
          ),
        key: Key("preguntas_frecuentes"),
        javascriptMode: JavascriptMode.disabled,
        initialUrl: "https://www.farmater.com.mx/infoapp/pages/questions.html")
    );
  }
}