import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glootie_marketplace/src/features/home/cubit/home_page_cubit.dart';
import 'package:glootie_marketplace/src/features/product_details/product_details_page.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';
import 'package:glootie_marketplace/src/shared/models/offer_model.dart';
import 'package:intl/intl.dart';

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

          final customer = state is HomePageLoaded ? state.customer : null;

          final offers = customer?.offers ?? <OfferModel>[];

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
                                buildBalanceDisplay(customer?.balance ?? 0),
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

  Widget buildBalanceDisplay(int balance) => Padding(
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
              formatBalance(balance),
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

  Widget listTile(
    OfferModel offer,
  ) =>
      ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 24.0,
        ),
        leading: Image.network(
          offer.product.image,
          width: 60.0,
          height: 60.0,
          fit: BoxFit.cover,
        ),
        title: Text(
          offer.product.name,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.acai,
          ),
        ),
        subtitle: Text(
          formatBalance(offer.price),
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Russo',
            fontSize: 24.0,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.pinky,
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductsDetailsPage(),
          ),
        ),
      );

  String formatBalance(int balance) => NumberFormat.currency(
        locale: 'en-US',
        symbol: '\$ ',
      ).format(balance == 0 ? 0 : balance / 100);

  Widget buildOffersList(List<OfferModel> offers) => ListView.builder(
        shrinkWrap: true,
        itemCount: offers.length,
        itemBuilder: (context, index) => listTile(offers[index]),
      );
}
