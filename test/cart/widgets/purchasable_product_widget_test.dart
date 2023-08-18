import 'package:digifood_test/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../pump_app.dart';
import '../../test_constants.dart';

class CartMock extends AutoDisposeNotifier<Map<String, int>>
    with Mock
    implements Cart {}

void main() {
  group('PurchasableProductWidget', () {
    testWidgets('Tap on add icon should call cart.addProduct(pizza).',
        (tester) async {
      final cart = CartMock();
      await tester.pumpApp(
        overrides: [cartProvider.overrideWith(() => cart)],
        const PurchasableProductWidget(
          product: pizza,
          quantity: 0,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      verify(cart.addProduct('Pizza'));
    });

    group('reduceProduct', () {
      testWidgets(
          'When quantity>0, tap on remove icon '
          'should call cart.reduceProduct(pizza).', (tester) async {
        final cart = CartMock();
        await tester.pumpApp(
          overrides: [cartProvider.overrideWith(() => cart)],
          const PurchasableProductWidget(
            product: pizza,
            quantity: 1,
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.remove));
        verify(cart.reduceProduct('Pizza'));
      });

      testWidgets(
          'When quantity==0, tap on remove icon '
          'should not call cart.reduceProduct(pizza).', (tester) async {
        final cart = CartMock();
        await tester.pumpApp(
          overrides: [cartProvider.overrideWith(() => cart)],
          const PurchasableProductWidget(
            product: pizza,
            quantity: 0,
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.remove));
        verifyNever(cart.reduceProduct('Pizza'));
      });
    });
  });
}
