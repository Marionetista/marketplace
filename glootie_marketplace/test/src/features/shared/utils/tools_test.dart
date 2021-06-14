import 'package:flutter_test/flutter_test.dart';
import 'package:glootie_marketplace/src/shared/utils/tools.dart';

void main() {
  test('Format customer balance',
      () => expect(formatBalance(1000000), '\$ 10,000.00'));
}
