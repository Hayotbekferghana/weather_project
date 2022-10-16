
import 'package:flutter/material.dart';
import 'package:weather_project/presentations/tabBox/home_page.dart';
import 'package:weather_project/presentations/tabBox/sql_page.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {

  int currentIndex = 0;

  List<Widget> screens = [
    HomePage(),
    SqlPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF343258),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 24,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: [
          getItem(icon: Icons.home, labelText: "Home"),
          getItem(icon: Icons.bookmark_border_outlined, labelText: "Notification"),
        ],
      ),
    );
  }
  BottomNavigationBarItem getItem(
      {required IconData icon, required String labelText}) {
    return BottomNavigationBarItem(
        label: labelText,
        icon: Icon(
          icon,
          color: const Color(0xFF889DC7),
        ),
        activeIcon: Icon(
          icon,
          color: Colors.white,
        ));
  }
}
