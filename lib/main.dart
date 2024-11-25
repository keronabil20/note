import 'package:flutter/material.dart';
import 'package:to_do_app/layout/home_screen.dart';
import 'package:to_do_app/layout/start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: name(),
    );
  }
}
  // This widget is the root of your application.
 