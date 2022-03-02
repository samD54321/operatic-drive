import 'package:flutter/material.dart';
import 'package:operatic_drive/utils/RouteGenerator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.SPLASH_SCREEN,
      debugShowCheckedModeBanner: false,
      title: "Operatic Drive",
    );
  }
}

