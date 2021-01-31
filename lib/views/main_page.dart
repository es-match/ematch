import 'package:ematch/views/group_page.dart';
import 'package:ematch/views/home_page.dart';
import 'package:ematch/views/schedule_page.dart';
import 'package:ematch/views/search_group_page.dart';
import 'package:ematch/views/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenIndex = 0;

  final List<Widget> _bottomNavPages = [
    HomePage(),
    SearchGroupPage(),
    SchedulePage(),
    GroupPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
          child: _bottomNavPages[_screenIndex]),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[700],
        currentIndex: _screenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Buscar evento',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
            ),
            label: 'Grupos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          setState(() {
            _screenIndex = index;
          });
        },
      ),
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         currentAccountPicture: ClipRRect(
      //           borderRadius: BorderRadius.circular(40),
      //           child: Image.network(
      //               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBGfoR24g82fsdyUuCCIb672C6sh1hQStEKw&usqp=CAU'),
      //         ),
      //         accountName: Text('John Doe'),
      //         accountEmail: Text('johndoe@mail.com'),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text('Inicio'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
