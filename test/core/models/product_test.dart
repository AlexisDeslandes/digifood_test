import 'package:digifood_test/core/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product', () {
    const product = Product(
      name: 'Pizza',
      price: 10,
      category: 'Food',
      imagePath: '/path/to/image',
    );
    test('2 products should be equals with the same fields.', () {
      expect(product == product.copyWith(), true);
    });

    test(
        'fromJson should work with '
        '{name, price, category, imagePath, description}', () {
      const json = {
        'name': 'Pizza',
        'price': 10,
        'category': 'Food',
        'imagePath': '/path/to/image',
      };
      expect(Product.fromJson(json), product);
    });
  });
}
