import 'package:flutter/material.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';

class ProductsDetailsPage extends StatefulWidget {
  ProductsDetailsPage() : super();

  @override
  _ProductsDetailsPageState createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 100,
          leading: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.pinky,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      );
}
