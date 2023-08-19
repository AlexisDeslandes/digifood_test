import 'package:flutter/widgets.dart';

/// Width of left part of the split screen.
const double leftScreenWidth = 600;

/// Extension to help draw on screen.
extension ScreenContext on BuildContext {
  /// Return the width of screen.
  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }

  /// Return true when the screen could be split.
  bool get shouldSplitScreen {
    return screenWidth >= 1000;
  }
}
