import 'dart:io';

/// Return true when currently testing.
bool isTesting() {
  return Platform.environment.containsKey('FLUTTER_TEST');
}
