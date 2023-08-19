import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    NavigatorObserver? navigatorObserver,
    List<Override> overrides = const [],
    Size? size,
  }) {
    Widget app = MaterialApp(
      navigatorObservers: [if (navigatorObserver != null) navigatorObserver],
      home: widget,
    );
    if (size != null) {
      app = MediaQuery(data: MediaQueryData(size: size), child: app);
    }
    app = ProviderScope(overrides: overrides, child: app);
    return pumpWidget(app);
  }
}
