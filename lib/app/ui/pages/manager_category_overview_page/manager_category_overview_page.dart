import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerCategoryOverviewPage extends StatelessWidget {
  final id = Get.parameters["id"]!;
  final name = Get.parameters["name"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? "Category Overview"),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Center(
        child: Text("Category data"),
      ),
    );
  }
}
