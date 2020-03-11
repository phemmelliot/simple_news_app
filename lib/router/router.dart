import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:news_flutter_app/pages/news_page/news_page.dart';
import 'package:news_flutter_app/pages/splash_screen/splash_screen.dart';
import 'package:news_flutter_app/utils/helper.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
        break;
      case '/news_screen':
        return MaterialPageRoute(builder: (context) => NewsPage());
        break;
      case '/news_webview':
        NewPageArgs pageArgs = settings.arguments as NewPageArgs;
        return MaterialPageRoute(builder: (context) => WebviewScaffold(
          url: pageArgs.url,
          appBar: new AppBar(
            title: new Text(pageArgs.title),
            backgroundColor: Color(0xFFC70000),
          ),
          initialChild: Container(
            color: Colors.white,
            child: const Center(
              child: Text('Waiting.....'),
            ),
          ),
        ));
    }
  }
}
