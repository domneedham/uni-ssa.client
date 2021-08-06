import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_form_controller.dart';

class ManagerSkillForm extends GetView<ManagerSkillFormController> {
  const ManagerSkillForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Name"),
              validator: controller.validateName,
              controller: controller.nameController,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              items: controller.categories
                  .map(
                    (element) => DropdownMenuItem(
                      value: element.id,
                      child: Text(element.name),
                    ),
                  )
                  .toList(),
              value: controller.selectedCategoryId,
              onChanged: (int? value) => controller.selectedCategoryId = value,
              decoration: InputDecoration(labelText: "Category"),
              validator: controller.validateCategory,
            ),
          ],
        ),
      ),
    );
  }
}
