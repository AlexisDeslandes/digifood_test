import 'package:digifood_test/cart/providers/providers.dart';
import 'package:digifood_test/core/models/models.dart';

const pizza = Product(
  name: 'Pizza',
  price: 10,
  category: 'Food',
);

const burger = Product(name: 'Burger', price: 8, category: 'Food');

class Cart2Pizza extends Cart {
  @override
  Map<String, int> build() {
    return {pizza.name: 2};
  }
}
