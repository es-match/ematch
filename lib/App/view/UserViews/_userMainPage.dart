import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/navigationPage.dart';
import 'package:ematch/App/view/UserViews/home/homePage.dart';
import 'package:ematch/App/view/UserViews/group/_groupPage.dart';
import 'package:ematch/App/view/UserViews/profilePage.dart';
// ignore: unused_import
import 'package:ematch/App/view/UserViews/schedule_page.dart';
import 'package:ematch/App/view/UserViews/searchGroupPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int _screenIndex = 0;
  int _screenIndex = 0;

  void changeIndex(int value) {
    setState(() {
      _screenIndex = value;
    });
  }

  // final List<Widget> _bottomNavPages = [];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final List<NavigationPage> _widgetPages = [
      NavigationPage(
          widget: HomePage(name: myShortname, changeIndexFunction: changeIndex),
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
            label: 'Buscar Grupos',
          )),
      //TODO:CALENDARIO ESCONDIDO
      // NavigationPage(
      //     widget: SchedulePage(),
      //     bottomNavItem: BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.calendar_today,
      //       ),
      //       label: 'Agenda',
      //     )),
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

    List<BottomNavigationBarItem> getBottomNavigationBarItems() {
      return _widgetPages.map((e) => e.bottomNavItem).toList();
    }

    return Scaffold(
      backgroundColor: Colors.black26,
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
        // showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepOrange,
        selectedItemColor: Colors.black,
        currentIndex: _screenIndex,
        items: getBottomNavigationBarItems(),
        onTap: (index) {
          changeIndex(index);
        },
      ),
    );
  }
}
