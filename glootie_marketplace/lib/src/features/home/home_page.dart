import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glootie_marketplace/src/features/home/cubit/home_page_cubit.dart';
import 'package:glootie_marketplace/src/features/product_details/cubit/product_details_cubit.dart';
import 'package:glootie_marketplace/src/features/product_details/product_details_page.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';
import 'package:glootie_marketplace/src/shared/models/customer_model.dart';
import 'package:glootie_marketplace/src/shared/models/offer_model.dart';
import 'package:glootie_marketplace/src/shared/utils/tools.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageCubit get cubit => BlocProvider.of<HomePageCubit>(context);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomePageCubit, HomePageState>(
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
                            flexibleSpace: buildPageTitle(customer?.name ?? ''),
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

  Padding buildPageTitle(String customerName) => Padding(
        padding: const EdgeInsets.only(
          top: 49.0,
          bottom: 16.0,
          left: 24.0,
          right: 24.0,
        ),
        child: Row(
          children: [
            Image.asset('assets/glootie.png'),
            SizedBox(
              width: 20,
            ),
            Text(
              'Hello $customerName! \nHere\'s your offers:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                color: AppColors.pinky,
              ),
            ),
          ],
        ),
      );

  Widget listTile(OfferModel offer) {
    final client = GraphQLProvider.of(context).value;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
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
      onTap: () async {
        final result = await Navigator.of(context).push<CustomerModel>(
          MaterialPageRoute(
            builder: (context) => BlocProvider<ProductDetailsCubit>(
              create: (context) => ProductDetailsCubit(client),
              child: ProductsDetailsPage(offer: offer),
            ),
          ),
        );
        cubit.updateCustomer(result);
      },
    );
  }

  Widget buildOffersList(List<OfferModel> offers) => ListView.builder(
        shrinkWrap: true,
        itemCount: offers.length,
        itemBuilder: (context, index) => listTile(offers[index]),
      );
}
