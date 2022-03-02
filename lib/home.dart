import 'package:flutter/material.dart';
import 'package:operatic_drive/homepage.dart';
import 'package:operatic_drive/library.dart';
import 'package:operatic_drive/player.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    MyHomePage(),

    MyLibrary(),
  ];

  final List<String> _childrenLabel =
      [
        "Home",
        "Songs Library"
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF36454F), const Color(0xFF353935)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(_childrenLabel[_selectedIndex]),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person_outlined),
              onPressed: () {},
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent, // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: _children[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            backgroundColor: Colors.transparent,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            onTap: (index) {
              _onItemTapped(index);
            },
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined, color: Colors.white)),
              BottomNavigationBarItem(
                  label: 'Library',
                  icon: Icon(Icons.library_add_outlined, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
