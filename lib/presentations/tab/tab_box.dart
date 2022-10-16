
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/data/local/local_db.dart';
import 'package:weather_project/data/models/cached_weather_info/cached_weather_item.dart';
import 'package:weather_project/data/services/local_notification_service.dart';
import 'package:weather_project/presentations/tab/home_page.dart';
import 'package:weather_project/presentations/tab/sql_page.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {

  @override
  void initState() {
    // background
    FirebaseMessaging.onMessageOpenedApp.listen(backgroundHandleMessage);
    // terminated
    onTerminated();
    // foreground
    FirebaseMessaging.onMessage.listen(LocalNotificationService.localNotificationService.showNotification);
    super.initState();
  }

  Future<void> onTerminated() async {
    await FirebaseMessaging.instance.getInitialMessage().then((v) async {
      if (v != null){
        var cachedWeatherItem = CachedWeatherItem(
          addressName: v.data["address"],
          weatherType: v.data["weather_type"],
          temperature: v.data["temp"],
        );
        await LocalDatabase.insertCachedWeather(cachedWeatherItem);
        Navigator.pushNamed(context, v.data["route"]);
      }
    });
  }
  Future<void> backgroundHandleMessage(RemoteMessage message) async {
    var cachedWeatherItem = CachedWeatherItem(
      addressName: message.data["address"],
      weatherType: message.data["weather_type"],
      temperature: message.data["temp"],
    );
    LocalDatabase.insertCachedWeather(cachedWeatherItem);
    Navigator.pushNamed(context, message.data["route"]);
  }
  int currentIndex = 0;

  List<Widget> screens = const [
    HomePage(),
    SqlPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      extendBody: true,
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