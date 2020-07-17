import 'package:covid19_tracker/screens/home.dart';
import 'package:covid19_tracker/screens/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static final _appRoutes = {
    '/': (BuildContext context) => SplashScreen(),
    '/home': (BuildContext context) => MyHomePage(),
  };

  static getRoutes() {
    return _appRoutes;
  }
}
