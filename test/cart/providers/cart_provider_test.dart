import 'package:digifood_test/cart/cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/riverpod_test.dart';

import '../../test_constants.dart';

void main() {
  group('Cart', () {
    group('addProduct', () {
      group('Add pizza', () {
        testNotifier(
          'If state is empty, state should be {Pizza:1}.',
          provider: cartProvider,
          act: (notifier) => notifier.addProduct(pizza.name),
          expect: () => [
            {'Pizza': 1},
          ],
        );

        testNotifier(
          'If state is {Pizza:1}, state should be {Pizza:2}.',
          provider: cartProvider,
          seed: {'Pizza': 1},
          act: (notifier) => notifier.addProduct(pizza.name),
          expect: () => [
            {'Pizza': 2},
          ],
        );
      });

      testNotifier(
        'Add burger, If state is {Pizza:1}, '
        'state should be {Pizza:1, Burger:1}.',
        provider: cartProvider,
        seed: {'Pizza': 1},
        act: (notifier) => notifier.addProduct(burger.name),
        expect: () => [
          {'Pizza': 1, 'Burger': 1},
        ],
      );
    });

    group('reduceProduct', () {
      testNotifier(
        'If productName not in state, throws an Exception.',
        provider: cartProvider,
        act: (notifier) => notifier.reduceProduct(pizza.name),
        errors: () => [isA<Exception>()],
      );

      testNotifier(
        'If state is {Pizza:2}, state should be {Pizza:1}.',
        provider: cartProvider,
        seed: {'Pizza': 2},
        act: (notifier) => notifier.reduceProduct(pizza.name),
        expect: () => [
          {'Pizza': 1},
        ],
      );
    });
  });

  group('productQuantity', () {
    testProvider(
      'When cartProvider has 2 pizza, expect 2.',
      provider: productQuantity(pizza.name),
      overrides: [cartProvider.overrideWith(Cart2Pizza.new)],
      expect: () => [2],
    );
  });
}
