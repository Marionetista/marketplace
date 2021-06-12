import 'package:flutter/material.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.whitePinky,
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    //ofertas e imagem
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
