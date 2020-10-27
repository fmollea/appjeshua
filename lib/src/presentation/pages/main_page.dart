import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/presentation/pages/favorite_page.dart';
import 'package:appjeshua/src/presentation/pages/help_page.dart';
import 'package:appjeshua/src/presentation/pages/pills_page.dart';
import 'package:appjeshua/src/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PillsPage(),
    ProfilePage(),
    FavoritePage(),
    HelpPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Utils.iconBottomColor,
      unselectedItemColor: Colors.white,
      backgroundColor: Utils.primaryColor,
      currentIndex: _currentIndex, // this will be set when a new tab is tapped
      type: BottomNavigationBarType.fixed,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(FlutterIcons.pill_mco),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: new Icon(FlutterIcons.person_outline_mdi),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: new Icon(FlutterIcons.favorite_border_mdi),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: new Icon(FlutterIcons.phone_call_fea),
          label: ''
        ),
      ],
    );
  }

  //events
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
