import 'package:digifood_test/cart/cart.dart';
import 'package:digifood_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Widget to add or reduce [product] from cart.
/// Connected to productQuantity provider to get quantity.
class PurchasableProductWidget extends ConsumerWidget {
  /// default constructor.
  const PurchasableProductWidget({required this.product, super.key});

  /// Product that will be added.
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(productQuantity(product.name));
    final isSelected = ref.watch(productFocusProvider) == product;
    return PurchasableProductWidgetSkeleton(
      product: product,
      quantity: quantity,
      isSelected: isSelected,
    );
  }
}

/// Widget skeleton to add or reduce [product] from cart.
@visibleForTesting
class PurchasableProductWidgetSkeleton extends ConsumerWidget {
  /// Default constructor.
  const PurchasableProductWidgetSkeleton({
    required this.product,
    required this.quantity,
    this.isSelected = false,
    super.key,
  });

  /// Product that will be added.
  final Product product;

  /// Current quantity of product in cart.
  final int quantity;

  /// True when selected product is the current one.
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productName = product.name;
    final colorScheme = Theme.of(context).colorScheme;
    final color = isSelected
        ? colorScheme.secondaryContainer
        : colorScheme.surfaceVariant;
    return Card(
      elevation: 0,
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (context.shouldSplitScreen) {
            final selected = isSelected ? null : product;
            ref.read(productFocusProvider.notifier).state = selected;
          } else {
            context.go('/products/$productName');
          }
        },
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Unit: ${product.price} €'),
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
      ),
    );
  }
}
