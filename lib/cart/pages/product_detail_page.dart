import 'dart:math';

import 'package:digifood_test/cart/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page that displays more data about a product.
class ProductDetailPage extends ConsumerWidget {
  /// default constructor
  const ProductDetailPage({required this.name, super.key});

  /// name of the product.
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double maxWidth = min(MediaQuery.of(context).size.width, 600);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final product = ref
        .read(fetchProductsProvider)
        .value
        ?.firstWhere((element) => element.name == name);
    Widget? body;
    if (product != null) {
      final description = product.description;
      body = Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 16,
                  children: [
                    Text(
                      name,
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
            const SizedBox(height: 16),
            if (description != null) Text(description),
          ],
        ),
      );
    }
    body ??= const SizedBox();

    final bgColor = theme.colorScheme.surfaceVariant;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Product detail'),
        backgroundColor: bgColor,
        elevation: 1,
      ),
      body: Row(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: body,
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
