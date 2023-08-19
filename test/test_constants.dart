import 'package:digifood_test/cart/providers/providers.dart';
import 'package:digifood_test/core/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

const pizza = Product(
  name: 'Pizza',
  price: 10,
  category: 'Food',
);

const burger = Product(name: 'Burger', price: 8, category: 'Food');

const sushi = Product(
  name: 'Sushi',
  price: 15,
  category: 'Food',
  description: 'My favorite food.',
);

class Cart2Pizza extends Cart {
  @override
  Map<String, int> build() {
    return {pizza.name: 2};
  }
}

class Cart2Pizza1Burger extends Cart {
  @override
  Map<String, int> build() {
    return {pizza.name: 2, burger.name: 1};
  }
}

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

class MockGoRouter extends Mock implements GoRouter {}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    super.key,
  });

  /// The mock navigator used to mock navigation calls.
  final MockGoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: goRouter,
        child: child,
      );
}
