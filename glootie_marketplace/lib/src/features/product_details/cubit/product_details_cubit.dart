import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glootie_marketplace/src/features/product_details/graphql/product_details_mutations.dart';
import 'package:glootie_marketplace/src/shared/models/customer_model.dart';
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

      final result = await graphQL
          .mutate(
            MutationOptions(
              document: gql(
                ProductDetailsMutation.purchase(offerId),
              ),
            ),
          )
          .timeout(
            Duration(seconds: 10),
          );

      final data = result.data!['purchase'] as Map<String, Object?>;

      emit(_makePurchaseResult(data));
    } catch (error) {
      emit(ProductDetailsError());
    }
  }

  ProductDetailsPurchaseResult _makePurchaseResult(Map<String, Object?> data) {
    final customer =
        CustomerModel.fromJson(data['customer'] as Map<String, Object?>);

    return ProductDetailsPurchaseResult(
      success: data['success'] as bool,
      customer: customer,
      errorMessage: data['errorMessage'] as String?,
    );
  }
}
