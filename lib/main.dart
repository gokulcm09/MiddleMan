import 'package:flutter/material.dart';

import './src/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Man',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        buttonColor: Colors.blue,
      ),
      theme: ThemeData(primarySwatch: Colors.blue, buttonColor: Colors.blue),
      home: IndexPage(),
    );
  }
}