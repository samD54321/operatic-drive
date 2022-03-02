import 'package:operatic_drive/home.dart';
import 'package:operatic_drive/homepage.dart';
import 'package:flutter/material.dart';
import 'package:operatic_drive/library.dart';
import 'package:operatic_drive/player.dart';
import 'package:operatic_drive/views/splash_screen.dart';

class RouteGenerator {
  static const String HOME_PAGE = '/',
      LIBRARY = '/library',
      MUSIC_PLAYER = "/player",
      SPLASH_SCREEN = "/ss";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HOME_PAGE:
        return MaterialPageRoute(builder: (_) => Home());
      case LIBRARY:
        return MaterialPageRoute(
            builder: (_) => MyLibrary());
      case MUSIC_PLAYER:
        var arg = args as List<String>;
        return MaterialPageRoute(builder: (_) => MyPlayer(arg[0]));

      default:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}
