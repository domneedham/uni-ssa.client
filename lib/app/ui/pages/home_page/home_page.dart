import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: FlutterLogo(
            size: controller.size.value,
            duration: Duration(seconds: 1, milliseconds: 500),
          ),
        ),
      ),
    );
  }
}
