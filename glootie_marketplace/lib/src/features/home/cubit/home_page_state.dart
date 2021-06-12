part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState extends Equatable {}

class HomePageLoading extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageError extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageLoaded extends HomePageState {
  final CustomerModel customer;

  HomePageLoaded({required this.customer});

  @override
  List<Object?> get props => [customer];
}
