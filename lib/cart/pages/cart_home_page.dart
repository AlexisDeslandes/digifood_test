import 'dart:math';

import 'package:digifood_test/cart/cart.dart';
import 'package:digifood_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page that displays the products grouped by categories.
/// Products can be added and removed.
class CartHomePage extends ConsumerWidget {
  /// default constructor.
  const CartHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double maxWidth = min(MediaQuery.of(context).size.width, 600);
    return Scaffold(
      body: Row(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: const Column(
              children: [
                Expanded(child: CartHomeBody()),
                CartSynthesis(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Body of the [CartHomePage].
class CartHomeBody extends ConsumerWidget {
  /// default constructor.
  const CartHomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsByCategory = ref.watch(productsByCategorySortedProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Digifood'),
          floating: true,
        ),
        ...productsByCategory.when(
          data: (data) {
            return [
              for (final (category, products) in data) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: PurchasableProductWidget(product: product),
                    );
                  },
                ),
              ],
            ];
          },
          error: (err, __) => [SliverToBoxAdapter(child: Text('Error: $err'))],
          loading: () => [
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CircularProgressIndicator(
                    value: isTesting() ? 1 : null,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}
