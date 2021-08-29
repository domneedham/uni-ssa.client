import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Shows a title for use when using a title on a page.
class PageTitle extends StatelessWidget {
  const PageTitle({Key? key, required this.text}) : super(key: key);

  /// The title text.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Get.textTheme.headline4,
      ),
    );
  }
}
