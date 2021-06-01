import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Creates a widget that allows GetX widgets to be tested.
/// Found from [GitHub](https://github.com/jonataslaw/getx/issues/418#issuecomment-694085362).
///
/// Made into a class following standard pratice for making widgets in Flutter.
class TestableWidget extends StatelessWidget {
  /// Creates a widget testable when using GetX.
  TestableWidget({required this.child});

  /// The widget to be tested.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: GetMaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }
}
