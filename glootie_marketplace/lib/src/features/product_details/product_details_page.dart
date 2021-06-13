import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glootie_marketplace/src/features/product_details/cubit/product_details_cubit.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';
import 'package:glootie_marketplace/src/shared/models/offer_model.dart';

class ProductsDetailsPage extends StatefulWidget {
  ProductsDetailsPage(
    this.offer,
  ) : super();

  final OfferModel offer;

  @override
  _ProductsDetailsPageState createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  ProductDetailsCubit get cubit =>
      BlocProvider.of<ProductDetailsCubit>(context);

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsPurchaseResult) {
            Navigator.pop(context, state.customer);
          }
        },
        builder: (context, state) => Scaffold(
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
                children: [
                  TextButton(
                    onPressed: () => cubit.onPurchase(widget.offer.id),
                    child: Text('Buy Now'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
