import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glootie_marketplace/src/features/home/cubit/home_page_cubit.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';

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
        builder: (context, snapshot) => Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  buildPageTitle(),
                  buildOfferCard(),
                  buildOfferCard(),
                  buildOfferCard(),
                ],
              ),
            ),
          ),
        ),
      );

  Padding buildPageTitle() => Padding(
        padding: const EdgeInsets.only(
          top: 49,
          bottom: 16,
          left: 24,
          right: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Offers',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.pink,
            ),
          ],
        ),
      );

  Widget buildDivider() => Column(
        children: const [
          SizedBox(height: 34.0),
          Divider(
            height: 1,
            color: AppColors.acai,
          ),
        ],
      );

  Widget buildOfferCard() => Container(
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
              child: Image.network(
                'https://picsum.photos/250?image=9',
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MeeseksBox',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.acai,
                    ),
                  ),
                  Text(
                    'R\$ 56,99',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
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
      );

  // Widget buildOffersList() => ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: pendingDeviceAuthorizations.length,
  //       itemBuilder: (context, index) => pendingDeviceCard(
  //           pendingDeviceAuthorization: pendingDeviceAuthorizations[index]),
  //     );
}
