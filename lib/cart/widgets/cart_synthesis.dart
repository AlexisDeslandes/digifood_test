import 'package:digifood_test/cart/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Synthesis of the cart, it let user knows the total price
/// & one day be able to validate cart.
class CartSynthesis extends ConsumerWidget {
  /// default constructor.
  const CartSynthesis({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final surface = colorScheme.surface;
    final surfaceTint = colorScheme.surfaceTint;
    final color = ElevationOverlay.applySurfaceTint(surface, surfaceTint, 2);
    final total = ref.watch(productsTotalProvider).maybeWhen(
          orElse: () => 0,
          data: (data) => data,
        );
    return Container(
      height: kBottomNavigationBarHeight,
      width: MediaQuery.of(context).size.width,
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total: $total €'),
          FilledButton(
            onPressed: total == 0 ? null : () {},
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}
