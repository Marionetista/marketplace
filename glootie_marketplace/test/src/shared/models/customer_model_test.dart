import 'package:flutter_test/flutter_test.dart';
import 'package:glootie_marketplace/src/shared/models/customer_model.dart';

final id = 'cccc3f48-dd2c-43ba-b8de-8945e7ababab';
final name = 'Jerry Smith';
final balance = 1000000;
final json = {
  'id': id,
  'name': name,
  'balance': balance,
  'offers': [
    {
      'id': 'offer/portal-gun',
      'price': 5000,
      'product': {
        'id': 'product/portal-gun',
        'name': 'Portal Gun',
        'description':
            'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.',
        'image':
            'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310'
      }
    },
    {
      'id': 'offer/microverse-battery',
      'price': 5507,
      'product': {
        'id': 'product/microverse-battery',
        'name': 'Microverse Battery',
        'description':
            'The Microverse Battery contains a miniature universe with a planet inhabited by intelligent life.',
        'image':
            'https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest/scale-to-width-down/310?cb=20160910010946'
      }
    },
  ]
};
void main() {
  test('Test Compare Model', () {
    final firstCustomer = CustomerModel.fromJson(json);
    final secondCustomer = CustomerModel.fromJson(json);

    expect(
      firstCustomer,
      secondCustomer,
    );
  });

  test('Test model from json', () {
    final customer = CustomerModel.fromJson(json);

    expect(customer.id, id);
    expect(customer.name, name);
    expect(customer.balance, balance);
    expect(customer.offers.length, 2);
  });
}
