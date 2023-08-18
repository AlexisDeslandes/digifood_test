import 'package:digifood_test/cart/providers/cart_provider.dart';
import 'package:digifood_test/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget to add or reduce [product] from cart.
class PurchasableProductWidget extends ConsumerWidget {
  /// Default constructor.
  const PurchasableProductWidget({
    required this.product,
    required this.quantity,
    super.key,
  });

  /// Product that will be added.
  final Product product;

  /// Current quantity of product in cart.
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productName = product.name;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text('Unité: ${product.price} €'),
              ],
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                children: [
                  IconButton.outlined(
                    onPressed: quantity == 0
                        ? null
                        : () {
                            ref
                                .read(cartProvider.notifier)
                                .reduceProduct(productName);
                          },
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$quantity'),
                  IconButton.filled(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addProduct(productName);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
