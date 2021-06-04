import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: Get.textTheme.headline4),
    );
  }
}
