import 'package:digifood_test/cart/cart.dart';
import 'package:digifood_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pump_app.dart';
import '../../test_constants.dart';

void main() {
  group('ProductDetailWidget', () {
    testWidgets('With sushi, we should have text(My favorite food.)',
        (tester) async {
      await tester.pumpApp(
        const Material(child: ProductDetailWidget(product: sushi)),
        overrides: [
          fetchProductsProvider.overrideWith((ref) => [sushi]),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.text('My favorite food.'), findsOneWidget);
    });
  });
}
