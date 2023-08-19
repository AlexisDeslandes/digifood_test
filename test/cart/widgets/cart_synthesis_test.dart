import 'package:digifood_test/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pump_app.dart';

void main() {
  group('CartSynthesis', () {
    testWidgets(
        'When total is 0, find text(Total: 0 €) button should be disabled.',
        (tester) async {
      await tester.pumpApp(
        const CartSynthesis(),
        overrides: [
          productsTotalProvider.overrideWithValue(const AsyncValue.data(0)),
        ],
      );
      await tester.pumpAndSettle();
      expect(find.text('Total: 0.0 €'), findsOneWidget);
      final buttonFinder = find.byType(FilledButton);
      final button = tester.widget<FilledButton>(buttonFinder);
      expect(button.onPressed, null);
    });
  });
}
