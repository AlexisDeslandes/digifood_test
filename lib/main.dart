import 'package:digifood_test/cart/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) {
        return const CartHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'products/:name',
          builder: (BuildContext context, GoRouterState state) {
            final name = state.pathParameters['name']!;
            return ProductDetailPage(name: name);
          },
        ),
      ],
    ),
  ],
);

/// My app
class MyApp extends StatelessWidget {
  /// default constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Digifood test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          //brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
