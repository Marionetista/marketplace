part of 'product_details_cubit.dart';

@immutable
abstract class ProductDetailsState extends Equatable {}

class ProductDetailsLoading extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

class ProductDetailsError extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

class ProductDetailsPurchaseResult extends ProductDetailsState {
  final bool success;
  final CustomerModel customer;
  final String? errorMessage;

  ProductDetailsPurchaseResult({
    required this.success,
    required this.customer,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        success,
        customer,
        errorMessage,
      ];
}
