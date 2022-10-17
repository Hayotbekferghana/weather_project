import 'package:flutter/material.dart';
import 'package:weather_project/presentations/tab/home_screen/home_screen.dart';
import 'package:weather_project/presentations/tab/weathers_screen/weathers_screen.dart';
import 'package:weather_project/utils/colors.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    const WeathersScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backGroundColor,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 15, 9, 128),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
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
            getItem(
                icon: Icons.bookmark_border_outlined,
                labelText: "Notification"),
          ],
        ),
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
          size: 27,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ));
  }
}
