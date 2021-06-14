import 'package:flutter_test/flutter_test.dart';
import 'package:glootie_marketplace/src/shared/models/product_model.dart';

final id = 'product/portal-gun';
final name = 'Portal Gun';
final description =
    'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.';
final image =
    'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310';
final json = {
  'id': id,
  'name': name,
  'description': description,
  'image': image,
};

void main() {
  test('Test Compare Model', () {
    final firstProduct = ProductModel.fromJson(json);
    final secondProduct = ProductModel.fromJson(json);

    expect(
      firstProduct,
      secondProduct,
    );
  });

  test('Test model from json', () {
    final product = ProductModel.fromJson(json);

    expect(product.id, id);
    expect(product.name, name);
    expect(product.description, description);
    expect(product.image, image);
  });
}
