import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_details_cubit_state.dart';

class ProductDetailsCubitCubit extends Cubit<ProductDetailsCubitState> {
  ProductDetailsCubitCubit() : super(ProductDetailsCubitInitial());
}
