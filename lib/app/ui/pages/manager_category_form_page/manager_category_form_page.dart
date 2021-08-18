import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_form_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';

import 'manager_category_form.dart';

class ManagerCategoryFormPage extends GetWidget<ManagerCategoryFormController> {
  const ManagerCategoryFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.formMode == ManagerCategoryFormMode.ADD
            ? const Text('Add Category')
            : const Text('Edit Category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: controller.save,
          )
        ],
      ),
      body: Obx(() {
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }

        return const ManagerCategoryForm();
      }),
    );
  }
}
