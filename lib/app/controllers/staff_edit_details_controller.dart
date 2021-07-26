import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class StaffEditDetailsController extends GetxController {
  final userRepo = Get.find<UserRepository>();

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  User get user => userRepo.user;

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

  void save() {
    final status = _formKey.currentState?.validate();
    if (status ?? false) {
      Get.snackbar("Excellent", "Forms looking good");
    } else {
      Get.snackbar("Terrible", "Forms looking not so good");
    }
  }
}
