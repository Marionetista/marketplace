import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glootie_marketplace/src/features/product_details/cubit/product_details_cubit.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';
import 'package:glootie_marketplace/src/shared/models/offer_model.dart';
import 'package:glootie_marketplace/src/shared/utils/tools.dart';

class ProductsDetailsPage extends StatefulWidget {
  ProductsDetailsPage({
    required this.offer,
  }) : super();

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
            final title = state.success ? 'Yeah!' : 'Oops';
            final message =
                state.success ? 'Purchase successful!' : state.errorMessage;
            return showMessage(
              context,
              title: title,
              message: message,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, state.customer);
              },
            );
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildProductImage(),
                        nameAndValue(),
                        buildDivider(),
                        buildDescription(),
                      ],
                    ),
                  ),
                ),
                buildButton(),
              ],
            ),
          ),
        ),
      );

  Widget buildProductImage() => Padding(
        padding: const EdgeInsets.only(
          top: 18.0,
          bottom: 50.0,
        ),
        child: Center(
          child: Image.network(
            widget.offer.product.image,
            width: 192.5,
            height: 200.0,
          ),
        ),
      );

  Widget nameAndValue() => Container(
        color: AppColors.whitePinky,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 32.0,
          ),
          title: Text(
            widget.offer.product.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            formatBalance(widget.offer.price),
            style: TextStyle(
              fontSize: 22.0,
              color: AppColors.pinky,
              fontFamily: 'Russo',
            ),
          ),
        ),
      );

  Widget buildDivider() => Container(
        color: AppColors.whitePinky,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: const [
              Divider(
                height: 1,
                color: AppColors.acai,
              ),
            ],
          ),
        ),
      );

  Widget buildDescription() => Container(
        color: AppColors.whitePinky,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 16.0,
                ),
                child: Text(
                  'Description',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.offer.product.description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.acai,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ElevatedButton(
          onPressed: () => cubit.onPurchase(widget.offer.id),
          style: ElevatedButton.styleFrom(
            primary: AppColors.pinky,
            shadowColor: AppColors.pinky,
            onPrimary: Colors.white,
            elevation: 0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 100.0,
            ),
            child: Text('BUY NOW'),
          ),
        ),
      );
}
