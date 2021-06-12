import 'package:equatable/equatable.dart';
import 'offer_model.dart';

class CustomerModel extends Equatable {
  const CustomerModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.offers,
  });

  final String id;
  final String name;
  final int balance;
  final List<OfferModel> offers;

  factory CustomerModel.fromJson(
    Map<String, Object?> json,
  ) =>
      CustomerModel(
        id: json['id'] as String,
        name: json['name'] as String,
        balance: json['balance'] as int,
        offers: (json['offers'] as List<Object?>)
            .map<OfferModel>(
              (json) => OfferModel.fromJson(
                json as Map<String, Object?>,
              ),
            )
            .toList(),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        balance,
        offers,
      ];
}
