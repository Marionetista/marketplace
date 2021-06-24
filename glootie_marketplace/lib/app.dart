import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glootie_marketplace/src/features/home/cubit/home_page_cubit.dart';
import 'package:glootie_marketplace/src/shared/graphql/custom_graphql_client.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'src/features/home/home_page.dart';

class App extends StatelessWidget {
  App() {
    final link = HttpLink(
      'https://staging-nu-needful-things.nubank.com.br/query',
      defaultHeaders: <String, String>{
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
            '.eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0'
            '.cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c',
      },
    );

    client = ValueNotifier<CustomGraphQLClient>(
      CustomGraphQLClient(
        link,
        GraphQLCache(store: InMemoryStore()),
      ),
    );
  }

  late final ValueNotifier<CustomGraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Glootie Marketplace',
        home: BlocProvider<HomePageCubit>(
          create: (context) => HomePageCubit(
            client.value,
          )..getCustomer(hasError: true),
          child: HomePage(),
        ),
      ),
    );
  }
}
