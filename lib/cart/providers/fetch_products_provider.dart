import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:digifood_test/core/models/models.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_products_provider.g.dart';

/// Fetch the products JSON list from assets and return it as List of product.
@riverpod
Future<List<Product>> fetchProducts(FetchProductsRef ref) async {
  await Future<void>.delayed(const Duration(seconds: 2));
  final content = (json.decode(
    await rootBundle.loadString('assets/products.json'),
  ) as List)
      .cast<Map<String, dynamic>>();
  return content.map(Product.fromJson).toList();
}

/// Return the list of category with their associated products.
/// Both sorted before return.
@riverpod
AsyncValue<List<(String, List<Product>)>> productsByCategorySorted(
  ProductsByCategorySortedRef ref,
) {
  final productsAsync = ref.watch(fetchProductsProvider);
  return productsAsync.whenData((products) {
    final productsByCategory = groupBy(products, (e) => e.category);
    return productsByCategory.entries
        .sortedBy((e) => e.key)
        .map((e) => (e.key, e.value.sortedBy((e) => e.name)))
        .toList();
  });
}
