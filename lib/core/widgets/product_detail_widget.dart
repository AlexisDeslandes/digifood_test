import 'package:digifood_test/core/core.dart';
import 'package:flutter/material.dart';

/// Widget to show product detail.
class ProductDetailWidget extends StatelessWidget {
  /// default constructor
  const ProductDetailWidget({required this.product, super.key});

  /// [Product] used in the widget.
  final Product product;

  @override
  Widget build(BuildContext context) {
    final description = product.description;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: textTheme.displaySmall,
                  ),
                  Chip(label: Text(product.category)),
                ],
              ),
              Text(
                '${product.price} €',
                style: textTheme.titleLarge,
              ),
            ],
          ),
          if (description != null)
            Column(
              children: [
                const SizedBox(height: 16),
                Text(description),
              ],
            ),
        ],
      ),
    );
  }
}
