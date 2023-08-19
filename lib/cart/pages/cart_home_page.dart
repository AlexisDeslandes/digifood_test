import 'package:digifood_test/cart/cart.dart';
import 'package:digifood_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider of product that is focused.
final productFocusProvider = StateProvider<Product?>((ref) => null);

/// Page that displays the products grouped by categories.
/// Products can be added and removed.
class CartHomePage extends ConsumerWidget {
  /// default constructor.
  const CartHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxWidth = context.shouldSplitScreen
        ? leftScreenWidth
        : MediaQuery.of(context).size.width;
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
          const Expanded(child: _CartDetailProduct()),
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

class _CartDetailProduct extends ConsumerWidget {
  const _CartDetailProduct();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productFocusProvider);
    if (product == null) return const SizedBox();
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 24, left: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(11),
          ),
          child: ProductDetailWidget(product: product),
        ),
      ),
    );
  }
}
