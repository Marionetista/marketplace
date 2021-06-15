import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glootie_marketplace/src/features/product_details/cubit/product_details_cubit.dart';
import 'package:glootie_marketplace/src/shared/graphql/custom_graphql_client.dart';
import 'package:glootie_marketplace/src/shared/models/customer_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomGraphQLClient extends Mock implements CustomGraphQLClient {}

class MockMutationOptions extends Mock implements MutationOptions {}

class MockQueryOptions extends Mock implements QueryOptions {}

final purchaseJson = {
  "purchase": {
    "success": true,
    "errorMessage": null,
    "customer": {
      "id": "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
      "name": "Jerry Smith",
      "balance": 995000,
      "offers": [
        {
          "id": "offer/portal-gun",
          "price": 5000,
          "product": {
            "id": "product/portal-gun",
            "name": "Portal Gun",
            "description":
                "The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.",
            "image":
                "https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310"
          }
        },
        {
          "id": "offer/microverse-battery",
          "price": 5507,
          "product": {
            "id": "product/microverse-battery",
            "name": "Microverse Battery",
            "description":
                "The Microverse Battery contains a miniature universe with a planet inhabited by intelligent life.",
            "image":
                "https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest/scale-to-width-down/310?cb=20160910010946"
          }
        },
        {
          "id": "offer/mr-meeseeks-box",
          "price": 999999999,
          "product": {
            "id": "product/mr-meeseeks-box",
            "name": "Mr. Meeseeks Box",
            "description":
                "The Mr. Meeseeks Box is a gadget that creates a Mr. Meeseeks for the purpose of completing one given objective.",
            "image":
                "https://vignette.wikia.nocookie.net/rickandmorty/images/f/f7/Mr._Meeseeks_Box.png/revision/latest/scale-to-width-down/310?cb=20160909153718"
          }
        },
        {
          "id": "offer/cognition-amplifier",
          "price": 1000000,
          "product": {
            "id": "product/cognition-amplifier",
            "name": "Cognition Amplifier",
            "description": "The cognition amplifier makes Snuffles smart.",
            "image":
                "https://vignette.wikia.nocookie.net/rickandmorty/images/2/27/Cognition_Amplifier.png/revision/latest/scale-to-width-down/180?cb=20140604001816"
          }
        }
      ]
    }
  }
};

final customer = CustomerModel.fromJson(
  purchaseJson['purchase']!['customer'] as Map<String, Object?>,
);

late CustomGraphQLClient graphQLClient;

void main() {
  setUpAll(() {
    registerFallbackValue(MockMutationOptions());
    registerFallbackValue(MockQueryOptions());
  });

  setUp(() {
    graphQLClient = MockCustomGraphQLClient();
  });

  blocTest<ProductDetailsCubit, ProductDetailsState>(
    'Test purchase',
    build: () {
      when(
        () => graphQLClient.mutate(any()).timeout(any()),
      ).thenAnswer(
        (_) => Future.value(
          QueryResult(
            source: QueryResultSource.network,
            data: purchaseJson,
          ),
        ),
      );

      return ProductDetailsCubit(graphQLClient);
    },
    act: (cubit) => cubit.onPurchase('offer/portal-gun'),
    expect: () => [
      ProductDetailsLoading(),
      ProductDetailsPurchaseResult(
        success: true,
        customer: customer,
      ),
    ],
  );

  blocTest<ProductDetailsCubit, ProductDetailsState>(
    'Test emit ProductDetailsError',
    build: () {
      when(
        () => graphQLClient.mutate(any()).timeout(any()),
      ).thenThrow(
        Exception(),
      );

      return ProductDetailsCubit(graphQLClient);
    },
    act: (cubit) => cubit.onPurchase(''),
    expect: () => [
      ProductDetailsLoading(),
      ProductDetailsError(),
    ],
  );
}
