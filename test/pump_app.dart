import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    NavigatorObserver? navigatorObserver,
    List<Override>? overrides,
  }) {
    Widget app = MaterialApp(
      navigatorObservers: [if (navigatorObserver != null) navigatorObserver],
      home: widget,
    );
    if (overrides != null) {
      app = ProviderScope(overrides: overrides, child: app);
    }
    return pumpWidget(app);
  }
}
