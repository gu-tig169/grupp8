import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'welcome_view.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      primarySwatch: Colors.grey
      ),
      home: WelcomeView(),
    );
  }
}
