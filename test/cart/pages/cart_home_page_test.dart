import 'package:digifood_test/cart/cart.dart';
import 'package:digifood_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pump_app.dart';
import '../../test_constants.dart';

void main() {
  group('CartHomePage', () {
    testWidgets('On loading, should find a CircularProgressIndicator.',
        (tester) async {
      await tester.pumpApp(
        const CartHomePage(),
        overrides: [
          productsByCategorySortedProvider
              .overrideWithValue(const AsyncValue.loading()),
          fetchProductsProvider.overrideWith((_) => []),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('On Error, should find a Text(Error: err).', (tester) async {
      await tester.pumpApp(
        const CartHomePage(),
        overrides: [
          productsByCategorySortedProvider.overrideWithValue(
            const AsyncValue.error('err', StackTrace.empty),
          ),
          fetchProductsProvider.overrideWith((_) => []),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.text('Error: err'), findsOneWidget);
    });

    testWidgets('On Data, should find PurchasableProductWidget.',
        (tester) async {
      await tester.pumpApp(
        const CartHomePage(),
        overrides: [
          productsByCategorySortedProvider.overrideWithValue(
            const AsyncValue.data([
              ('Food', [pizza]),
            ]),
          ),
          fetchProductsProvider.overrideWith((_) => []),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(PurchasableProductWidget), findsWidgets);
    });

    testWidgets('When product is focused, render a ProductDetailWidget.',
        (tester) async {
      await tester.pumpApp(
        const CartHomePage(),
        overrides: [
          productFocusProvider.overrideWith((ref) => pizza),
          fetchProductsProvider.overrideWith((ref) => [pizza]),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.byType(ProductDetailWidget), findsOneWidget);
    });
  });
}
