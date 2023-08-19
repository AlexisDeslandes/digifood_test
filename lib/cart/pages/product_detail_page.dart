import 'package:digifood_test/cart/providers/providers.dart';
import 'package:digifood_test/core/core.dart';
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
    final theme = Theme.of(context);
    final product = ref
        .read(fetchProductsProvider)
        .value
        ?.firstWhere((element) => element.name == name);
    Widget? body;
    if (product != null) body = ProductDetailWidget(product: product);
    body ??= const SizedBox();

    final bgColor = theme.colorScheme.surfaceVariant;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Product detail'),
        backgroundColor: bgColor,
        elevation: 1,
      ),
      body: body,
    );
  }
}
