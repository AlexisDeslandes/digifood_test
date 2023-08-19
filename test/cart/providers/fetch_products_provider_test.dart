import 'package:digifood_test/cart/cart.dart';
import 'package:digifood_test/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('fetchProducts', () {
    test('Should get 8 products.', () async {
      final container = ProviderContainer();
      expect(
        container.read(fetchProductsProvider),
        const AsyncValue<List<Product>>.loading(),
      );
      final products = await container.read(fetchProductsProvider.future);
      expect(products.length, 8);
    });
  });

  group('productsByCategorySorted', () {
    test('With pizza, burger => return [(Food, [burger, pizza])]', () {
      final container = ProviderContainer(
        overrides: [
          fetchProductsProvider.overrideWith((_) => [pizza, burger]),
        ],
      );
      final value = container.read(productsByCategorySortedProvider).value!;
      expect(value.length, 1);
      final (category, list) = value.first;
      expect(category, 'Food');
      expect(list, [burger, pizza]);
    });
  });
}
