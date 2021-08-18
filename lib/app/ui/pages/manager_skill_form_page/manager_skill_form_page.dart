import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_form_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/manager_skill_form.dart';

class ManagerSkillFormPage extends GetWidget<ManagerSkillFormController> {
  const ManagerSkillFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.formMode == ManagerSkillFormMode.ADD
            ? const Text('Add Skill')
            : const Text('Edit Skill'),
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
        if (controller.categories.isNotEmpty) {
          return const ManagerSkillForm();
        }
        if (controller.categories.isEmpty) {
          return const FutureStateText(
              text: 'You must create a category first');
        }
        return const FutureStateText(text: 'Unknown state');
      }),
    );
  }
}
