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
  group('PurchasableProductWidgetSkeleton', () {
    testWidgets('Tap on add icon should call cart.addProduct(pizza).',
        (tester) async {
      final cart = CartMock();
      await tester.pumpApp(
        overrides: [cartProvider.overrideWith(() => cart)],
        const PurchasableProductWidgetSkeleton(
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
          const PurchasableProductWidgetSkeleton(
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
          MockGoRouterProvider(
            goRouter: MockGoRouter(),
            child: const PurchasableProductWidgetSkeleton(
              product: pizza,
              quantity: 0,
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.remove));
        verifyNever(cart.reduceProduct('Pizza'));
      });
    });

    group('tap on widget', () {
      testWidgets('With little screen, it should navigate to product detail.',
          (tester) async {
        final router = MockGoRouter();
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: router,
            child: const PurchasableProductWidgetSkeleton(
              product: pizza,
              quantity: 0,
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byType(PurchasableProductWidgetSkeleton));
        verify(router.go('/products/Pizza'));
      });

      testWidgets('With bigger screen, it should set product focus to pizza.',
          (tester) async {
        await tester.pumpApp(
          const PurchasableProductWidgetSkeleton(
            product: pizza,
            quantity: 0,
          ),
          size: const Size.fromWidth(1000),
          overrides: [productFocusProvider.overrideWith((ref) => null)],
        );
        await tester.pumpAndSettle();
        final context =
            tester.element(find.byType(PurchasableProductWidgetSkeleton));
        final providerContainer = ProviderScope.containerOf(context);
        expect(providerContainer.read(productFocusProvider), null);
        await tester.tap(find.byType(PurchasableProductWidgetSkeleton));
        expect(providerContainer.read(productFocusProvider), pizza);
      });
    });
  });

  group('PurchasableProductWidget', () {
    testWidgets('Tap on add icon should change text from 0 to 1.',
        (tester) async {
      await tester.pumpApp(const PurchasableProductWidget(product: pizza));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });
  });
}
