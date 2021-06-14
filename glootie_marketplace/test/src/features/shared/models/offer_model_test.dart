import 'package:flutter_test/flutter_test.dart';
import 'package:glootie_marketplace/src/shared/models/offer_model.dart';

final id = 'offer/portal-gun';
final price = 5000;
final json = {
  'id': id,
  'price': price,
  'product': {
    'id': 'product/portal-gun',
    'name': 'Portal Gun',
    'description':
        'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.',
    'image':
        'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310'
  }
};

void main() {
  test('Test Compare Model', () {
    final firstOffer = OfferModel.fromJson(json);
    final secondOffer = OfferModel.fromJson(json);

    expect(
      firstOffer,
      secondOffer,
    );
  });

  test('Test model from json', () {
    final offer = OfferModel.fromJson(json);

    expect(offer.id, id);
    expect(offer.price, price);
  });
}
