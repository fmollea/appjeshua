import 'package:appjeshua/src/commons/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpPage extends StatelessWidget {

  final bool isBottomOptionPage;

  const HelpPage({Key key, this.isBottomOptionPage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _drawAppBar(),
      body: WebView(
        gestureNavigationEnabled: true,
        gestureRecognizers: Set()
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
            ), // or null
          ),
        key: Key(Utils.titleContact),
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://www.jeshuamedic.com/infoapp")
    );
  }

  _drawAppBar() {
    return isBottomOptionPage ? AppBar(title: Text(Utils.titleContact), leading: Container(), centerTitle: true,) :
      AppBar(title: Text(Utils.titleContact), centerTitle: true,); 
  }

}