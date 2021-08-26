import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class StaffEditDetailsController extends GetxController {
  final userService = Get.find<UserService>();

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  Staff get user => userService.user as Staff;

  final firstnameController = TextEditingController();
  final surnameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    firstnameController.value = TextEditingValue(text: user.firstname);
    surnameController.value = TextEditingValue(text: user.surname);
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  Future<void> save() async {
    final status = _formKey.currentState?.validate();
    if (status ?? false) {
      try {
        final staff = Staff(
          id: user.id,
          firstname: firstnameController.value.text,
          surname: surnameController.value.text,
          skills: user.skills,
          manager: user.manager,
        );
        await userService.updateStaffDetails(staff);

        Get.snackbar('Success', 'Name updated');
      } catch (e) {
        Get.snackbar('Update failed', e.toString());
      }
    }
  }
}
