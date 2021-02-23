import 'package:ematch/App/view/OwnerViews/overviewPage.dart';
import 'package:ematch/App/view/OwnerViews/profilePage.dart';
import 'package:ematch/App/view/OwnerViews/revenuePage.dart';
import 'package:flutter/material.dart';

import 'lastnewsPage.dart';

class OwnerMainPage extends StatefulWidget {
  @override
  _OwnerMainPageState createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  int _screenIndex = 0;

  final List<OwnerNavigationPages> _widgetPages = [
    OwnerNavigationPages(
        widget: OverViewPage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Resumo',
        )),
    OwnerNavigationPages(
        widget: RevenuePage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: 'Receita',
        )),
    OwnerNavigationPages(
        widget: LastNewsPage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications,
          ),
          label: 'Ultimas Noticias',
        )),
    OwnerNavigationPages(
        widget: ProfilePage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Resumo',
        )),
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Container(
        height: _height,
        width: _width,
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
          child: Container(child: _widgetPages[_screenIndex].widget),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[700],
        currentIndex: _screenIndex,
        items: getBottomNavigationBarItems(),
        onTap: (index) {
          setState(() {
            _screenIndex = index;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return _widgetPages.map((e) => e.bottomNavItem).toList();
  }
}

class OwnerNavigationPages {
  final Widget widget;
  final BottomNavigationBarItem bottomNavItem;

  OwnerNavigationPages({this.widget, this.bottomNavItem});
}
