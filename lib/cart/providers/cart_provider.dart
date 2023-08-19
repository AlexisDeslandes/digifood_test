import 'package:collection/collection.dart';
import 'package:digifood_test/cart/cart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

/// State for the cart object.
/// Its contains a map of product name associated to the number of product.
@riverpod
class Cart extends _$Cart {
  @override
  Map<String, int> build() {
    return const {};
  }

  /// Add 1 product of [productName] to state map.
  void addProduct(String productName) {
    final oldValue = state[productName] ?? 0;
    state = {
      ...state,
      productName: oldValue + 1,
    };
  }

  /// Reduce 1 product of [productName] of state map.
  void reduceProduct(String productName) {
    final oldValue = state[productName];
    if (oldValue == null || oldValue == 0) {
      throw Exception('Impossible to reduce value on $productName: value=0.');
    }
    state = {
      ...state,
      productName: oldValue - 1,
    };
  }
}

/// Provider that return the product quantity from name of product.
final productQuantity = Provider.autoDispose.family<int, String>(
  (ref, arg) {
    final cart = ref.watch(cartProvider);
    return cart[arg] ?? 0;
  },
);

/// Provider that return the total price of the cart.
@riverpod
AsyncValue<double> productsTotal(ProductsTotalRef ref) {
  final products = ref.read(fetchProductsProvider);
  final cart = ref.watch(cartProvider);
  return products.whenData((value) {
    return value.map((e) {
      final quantity = cart[e.name] ?? 0;
      return e.price * quantity;
    }).sum;
  });
}
