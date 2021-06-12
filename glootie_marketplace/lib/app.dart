import 'package:flutter/material.dart';
import 'package:glootie_marketplace/src/pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glootie Marketplace',
      home: HomePage(),
    );
  }
}
