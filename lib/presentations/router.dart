import 'package:flutter/material.dart';
import 'package:weather_project/presentations/tab/home_screen/home_screen.dart';
import 'package:weather_project/presentations/tab/weathers_screen/weathers_screen.dart';
import 'package:weather_project/presentations/tab/tab_box.dart';
import 'package:weather_project/utils/constants.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return navigateTo( HomeScreen());
      case sqlRoute:
        return navigateTo(const WeathersScreen());
      case tabRoute:
        return navigateTo(const TabBox());
      default:
        return navigateTo(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

MaterialPageRoute navigateTo(Widget widget) => MaterialPageRoute(
      builder: (context) => widget,
    );
