import 'package:flutter/material.dart';
import 'package:glootie_marketplace/src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glootie Marketplace',
      home: HomePage(),
    );
  }
}
