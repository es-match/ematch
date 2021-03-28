import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/navigationPage.dart';
import 'package:ematch/App/view/UserViews/home/home_page.dart';
import 'package:ematch/App/view/UserViews/group/_groupPage.dart';
import 'package:ematch/App/view/UserViews/profile_page.dart';
import 'package:ematch/App/view/UserViews/schedule_page.dart';
import 'package:ematch/App/view/UserViews/search_group_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override 
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenIndex = 0;

  final List<NavigationPage> _widgetPages = [
    NavigationPage(
        widget: HomePage(name: myShortname),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Inicio',
        )),
    NavigationPage(
        widget: SearchGroupPage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: 'Buscar Eventos',
        )),
    NavigationPage(
        widget: SchedulePage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
          ),
          label: 'Agenda',
        )),
    NavigationPage(
        widget: GroupPage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(
            Icons.group,
          ),
          label: 'Grupos',
        )),
    NavigationPage(
        widget: ProfilePage(),
        bottomNavItem: BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        )),
  ];

  // final List<Widget> _bottomNavPages = [];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      // appBar: AppBar(
      //   title: Text('Ola, ' + myShortname),
      // )
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
