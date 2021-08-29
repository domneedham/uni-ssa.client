import 'package:flutter/material.dart';

/// Shows centered text for showing states of the screen.
class FutureStateText extends StatelessWidget {
  const FutureStateText({
    Key? key,
    required this.text,
  }) : super(key: key);

  /// The text to be shown.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
