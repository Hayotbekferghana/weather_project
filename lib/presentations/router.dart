import 'package:flutter/material.dart';
import 'package:weather_project/presentations/tabBox/home_page.dart';
import 'package:weather_project/presentations/tabBox/sql_page.dart';
import 'package:weather_project/presentations/tabBox/tab_box.dart';
import 'package:weather_project/utils/constants.dart';

class MyRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute: return navigateTo(HomePage());
      case sqlRoute: return navigateTo(SqlPage());
      case tabRoute: return navigateTo(TabBox());
      default:
        return navigateTo(
          Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))),
        );
    }
  }
}

MaterialPageRoute navigateTo(Widget widget) => MaterialPageRoute(
  builder: (context) => widget,
);
