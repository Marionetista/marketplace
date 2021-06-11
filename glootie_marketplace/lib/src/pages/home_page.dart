import 'package:flutter/material.dart';
import 'package:glootie_marketplace/src/resources/appColors.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePink,
      appBar: AppBar(
        backgroundColor: AppColors.violet,
        title: Text(
          'I\'ve developed his app',
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 100,
                ),
                child: Text(
                  'Saldo: ',
                  textAlign: TextAlign.start,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
