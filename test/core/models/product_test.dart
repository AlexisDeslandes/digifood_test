import 'package:digifood_test/core/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_constants.dart';

void main() {
  group('Product', () {
    test('2 products should be equals with the same fields.', () {
      expect(pizza == pizza.copyWith(), true);
    });

    test(
        'fromJson should work with '
        '{name, price, category, imagePath, description}', () {
      const json = {
        'name': 'Pizza',
        'price': 10,
        'category': 'Food',
      };
      expect(Product.fromJson(json), pizza);
    });
  });
}
