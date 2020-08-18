import 'package:appjeshua/src/presentation/widget/empty_state_widget.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _drawAppBar(), body: _drawScreen());
  }

  Widget _drawAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Centro de notificaciones',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _drawScreen() {
    return EmptyStateWidget(
      text: 'No posee notificaciones.',
      path: 'assets/lottie_empty_notification.json',
    );
  }
}
