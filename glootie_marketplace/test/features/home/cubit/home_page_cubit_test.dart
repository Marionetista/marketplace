import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glootie_marketplace/src/features/home/cubit/home_page_cubit.dart';
import 'package:glootie_marketplace/src/shared/graphql/custom_graphql_client.dart';
import 'package:glootie_marketplace/src/shared/models/models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomGraphQLClient extends Mock implements CustomGraphQLClient {}

class MockQueryOptions extends Mock implements QueryOptions {}

final customerJson = {
  'viewer': {
    'id': 'cccc3f48-dd2c-43ba-b8de-8945e7ababab',
    'name': 'Jerry Smith',
    'balance': 1000000,
    'offers': [
      {
        'id': 'offer/portal-gun',
        'price': 5000,
        'product': {
          'id': 'product/portal-gun',
          'name': 'Portal Gun',
          'description':
              'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.',
          'image':
              'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310'
        }
      },
      {
        'id': 'offer/microverse-battery',
        'price': 5507,
        'product': {
          'id': 'product/microverse-battery',
          'name': 'Microverse Battery',
          'description':
              'The Microverse Battery contains a miniature universe with a planet inhabited by intelligent life.',
          'image':
              'https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest/scale-to-width-down/310?cb=20160910010946'
        }
      },
    ]
  },
};

final customer =
    CustomerModel.fromJson(customerJson['viewer'] as Map<String, Object?>);
late CustomGraphQLClient graphQLClient;

void main() {
  setUpAll(() {
    registerFallbackValue(
      MockQueryOptions(),
    );
  });

  setUp(() {
    graphQLClient = MockCustomGraphQLClient();
  });

  blocTest<HomePageCubit, HomePageState>(
    'Test HomePageLoaded',
    build: () {
      when(
        () => graphQLClient.query(any()).timeout(any()),
      ).thenAnswer(
        (_) => Future.value(
          QueryResult(
            source: QueryResultSource.network,
            data: customerJson,
          ),
        ),
      );

      return HomePageCubit(graphQLClient);
    },
    act: (cubit) => cubit.getCustomer(),
    expect: () => [
      HomePageLoading(),
      HomePageLoaded(customer: customer),
    ],
  );

  blocTest<HomePageCubit, HomePageState>(
    'Test Error',
    build: () {
      when(
        () => graphQLClient.query(any()).timeout(any()),
      ).thenThrow(
        Exception(),
      );

      return HomePageCubit(graphQLClient);
    },
    act: (cubit) => cubit.getCustomer(),
    expect: () => [
      HomePageLoading(),
      HomePageError(),
    ],
  );
}
