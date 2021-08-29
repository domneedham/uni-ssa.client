import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class LoginController extends GetxController {
  final userService = Get.find<UserService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isError = false.obs;
  final error = ''.obs;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    if (!GetUtils.isEmail(value)) {
      return 'Email is not valid';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 8) {
      return 'Password needs to be 8 characters or more';
    }

    return null;
  }

  Future<void> login() async {
    final status = _formKey.currentState?.validate();
    if (status ?? false) {
      final email = emailController.text;
      final password = passwordController.text;

      try {
        await userService.loginEmailPassword(email, password);
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }
}
