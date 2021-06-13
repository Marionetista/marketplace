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

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}
