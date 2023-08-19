import 'package:digifood_test/cart/cart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pump_app.dart';
import '../../test_constants.dart';

void main() {
  group('ProductDetailPage', () {
    testWidgets('With sushi, we should have text(My favorite food.)',
        (tester) async {
      await tester.pumpApp(
        ProductDetailPage(name: sushi.name),
        overrides: [
          fetchProductsProvider.overrideWith((ref) => [sushi]),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.text('My favorite food.'), findsOneWidget);
    });
  });
}
