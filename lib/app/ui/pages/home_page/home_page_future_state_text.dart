import 'package:flutter/material.dart';

class HomePageFutureStateText extends StatelessWidget {
  const HomePageFutureStateText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
}
