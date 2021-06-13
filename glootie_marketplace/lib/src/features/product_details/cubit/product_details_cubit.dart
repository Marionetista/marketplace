import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glootie_marketplace/src/features/product_details/graphql/product_details_mutations.dart';
import 'package:glootie_marketplace/src/shared/models/product_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(
    this.graphQL,
  ) : super(ProductDetailsLoading());

  final GraphQLClient graphQL;

  Future<void> onPurchase(String offerId) async {
    try {
      emit(ProductDetailsLoading());

      final result = await graphQL.mutate(
        MutationOptions(
          document: gql(
            ProductDetailsMutation.purchase(offerId),
          ),
        ),
      );
    } catch (error) {
      emit(ProductDetailsError());
    }
  }
}
