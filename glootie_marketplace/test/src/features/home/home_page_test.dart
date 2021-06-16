import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glootie_marketplace/src/features/home/cubit/home_page_cubit.dart';
import 'package:glootie_marketplace/src/features/home/home_page.dart';
import 'package:glootie_marketplace/src/features/product_details/product_details_page.dart';
import 'package:glootie_marketplace/src/shared/graphql/custom_graphql_client.dart';
import 'package:glootie_marketplace/src/shared/models/customer_model.dart';
import 'package:glootie_marketplace/src/shared/utils/tools.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockCustomGraphQLClient extends Mock implements CustomGraphQLClient {}

class MockQueryOptions extends Mock implements QueryOptions {}

class MockHomePageCubit extends MockCubit<HomePageState>
    implements HomePageCubit {}

class FakeHomePageStateState extends Fake implements HomePageState {}

final customerName = 'Jerry Smith';
final balance = 1000000;
final offerPrice = 5000;

final customerJson = {
  'viewer': {
    'id': 'cccc3f48-dd2c-43ba-b8de-8945e7ababab',
    'name': customerName,
    'balance': balance,
    'offers': [offersJson]
  },
};

final offersJson = {
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
};

final customer =
    CustomerModel.fromJson(customerJson['viewer'] as Map<String, Object?>);

late CustomGraphQLClient customgraphQLClient;
late HomePageCubit _cubit;

void main() {
  setUpAll(() {
    registerFallbackValue(MockQueryOptions());
    registerFallbackValue<HomePageState>(FakeHomePageStateState());
  });

  tearDown(() {
    _cubit.close();
  });

  setUp(() {
    _cubit = MockHomePageCubit();
    customgraphQLClient = MockCustomGraphQLClient();
  });

  testWidgets(
    'Find Loading Screen',
    (tester) async {
      when(() => _cubit.state).thenReturn(HomePageLoading());

      when(
        () => customgraphQLClient.query(any()).timeout(any()),
      ).thenAnswer(
        (_) => Future.value(
          QueryResult(
            source: QueryResultSource.network,
            data: customerJson,
          ),
        ),
      );

      await _createWidget(tester);

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Find widgets',
    (tester) async {
      when(() => _cubit.state).thenReturn(HomePageLoaded(customer: customer));

      when(
        () => customgraphQLClient.query(any()).timeout(any()),
      ).thenAnswer(
        (_) => Future.value(
          QueryResult(
            source: QueryResultSource.network,
            data: customerJson,
          ),
        ),
      );

      await _createWidget(tester);
      await tester.pump();

      final image = tester.widget<Image>(find.byType(Image).first);
      expect((image.image as AssetImage).assetName, 'assets/glootie.png');

      expect(
        find.text('Hello $customerName! \nHere\'s your offers:'),
        findsOneWidget,
      );

      expect(find.text(formatBalance(balance)), findsOneWidget);

      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);

      expect(find.text('Portal Gun'), findsOneWidget);
      expect(find.text(formatBalance(offerPrice)), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    },
  );

  testWidgets(
    'Test navigation',
    (tester) async {
      when(() => _cubit.state).thenReturn(HomePageLoaded(customer: customer));

      when(
        () => customgraphQLClient.query(any()).timeout(any()),
      ).thenAnswer(
        (_) => Future.value(
          QueryResult(
            source: QueryResultSource.network,
            data: customerJson,
          ),
        ),
      );

      await _createWidget(tester);
      await tester.pump();

      await tester.tap(find.byType(ListTile));

      await tester.pump();
      await tester.pump();

      expect(find.byType(ProductsDetailsPage), findsOneWidget);
    },
  );
}

Future<void> _createWidget(
  WidgetTester tester,
) async {
  await mockNetworkImages(() async {
    await tester.pumpWidget(
      GraphQLProvider(
        client: ValueNotifier<GraphQLClient>(
          customgraphQLClient,
        ),
        child: MaterialApp(
          home: BlocProvider<HomePageCubit>.value(
            value: _cubit,
            child: HomePage(),
          ),
        ),
      ),
    );
  });
}
