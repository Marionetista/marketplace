import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glootie_marketplace/src/features/home/graphql/home_queries.dart';
import 'package:glootie_marketplace/src/shared/graphql/custom_graphql_client.dart';
import 'package:glootie_marketplace/src/shared/models/models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this.graphQL,
  ) : super(HomePageLoading());

  final CustomGraphQLClient graphQL;

  Future<void> getCustomer() async {
    try {
      emit(HomePageLoading());

      final result = await graphQL
          .query(
            QueryOptions(
              document: gql(HomeQueries.customer),
            ),
          )
          .timeout(
            Duration(seconds: 10),
          );

      final data = result.data!['viewer'] as Map<String, Object?>;

      final customer = CustomerModel.fromJson(data);

      emit(HomePageLoaded(customer: customer));
    } catch (error) {
      emit(HomePageError());
    }
  }

  void updateCustomer(CustomerModel? customer) async {
    if (customer != null) {
      emit(
        HomePageLoaded(customer: customer),
      );
    }
  }
}
