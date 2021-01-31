import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/presentation/pages/favorite_page.dart';
import 'package:appjeshua/src/presentation/pages/help_page.dart';
import 'package:appjeshua/src/presentation/pages/pills_page.dart';
import 'package:appjeshua/src/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PillsPage(),
    ProfilePage(isBottomOptionPage: true),
    FavoritePage(isBottomOptionPage: true),
    HelpPage(isBottomOptionPage: true)
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
    if (index == 3) {
      _call(Utils.urlCellphone());
    } else {
      setState(() {
      _currentIndex = index;
    });
    }
  }

  _call(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
