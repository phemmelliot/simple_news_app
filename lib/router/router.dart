import 'package:flutter/material.dart';
import 'package:news_flutter_app/pages/news_page/news_page.dart';
import 'package:news_flutter_app/pages/splash_screen/splash_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
        break;
      case '/news_screen':
        return MaterialPageRoute(builder: (context) => NewsPage());
    }
  }
}
