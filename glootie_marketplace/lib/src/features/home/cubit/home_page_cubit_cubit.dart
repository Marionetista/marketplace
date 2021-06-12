import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_cubit_state.dart';

class HomePageCubitCubit extends Cubit<HomePageCubitState> {
  HomePageCubitCubit() : super(HomePageCubitInitial());
}
