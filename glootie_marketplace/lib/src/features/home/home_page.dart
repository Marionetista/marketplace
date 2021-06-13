import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glootie_marketplace/src/features/home/cubit/home_page_cubit.dart';
import 'package:glootie_marketplace/src/features/product_details/product_details_page.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';
import 'package:glootie_marketplace/src/shared/models/offer_model.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          final isLoading = state is HomePageLoading;

          final offers =
              state is HomePageLoaded ? state.customer.offers : <OfferModel>[];

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.pinky,
                      ),
                    )
                  : Container(
                      color: AppColors.whitePinky,
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: Colors.white,
                            expandedHeight: 120.0,
                            flexibleSpace: buildPageTitle(),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                buildBalanceDisplay(),
                                buildOffersList(offers),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      );

  Padding buildPageTitle() => Padding(
        padding: const EdgeInsets.only(
          top: 49.0,
          bottom: 16.0,
          left: 24.0,
          right: 24.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Offers',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset('assets/glootie.png'),
          ],
        ),
      );

  Widget buildBalanceDisplay() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 24.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Balance: ',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              '\$ 10000',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Russo',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget buildOfferCard({
    required String image,
    required String productName,
    required String price,
  }) =>
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductsDetailsPage()),
          );
        },
        child: Container(
          height: 112.0,
          color: AppColors.whitePinky,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 20.0,
                ),
                child: Image.network(image),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.acai,
                      ),
                    ),
                    Text(
                      '\$ $price',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Russo',
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.pinky,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildOffersList(List<OfferModel> offers) => ListView.builder(
        shrinkWrap: true,
        itemCount: offers.length,
        itemBuilder: (context, index) => buildOfferCard(
          productName: offers[index].product.name,
          price: offers[index].price.toString(),
          image: offers[index].product.image,
        ),
      );
}
