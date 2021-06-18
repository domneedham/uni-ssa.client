import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';

class ManagerCategoryOverviewPage
    extends GetView<ManagerCategoryOverviewController> {
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
      body: Obx(() {
        if (controller.category != null) {
          final category = controller.category!.value;
          return ListView(
            physics: ClampingScrollPhysics(),
            children: [Text(category.name)],
          );
        }
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return LoadingIndicator();
        }
        return FutureStateText(text: "Unknown state");
      }),
    );
  }
}
