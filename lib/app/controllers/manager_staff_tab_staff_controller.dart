import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

class ManagerStaffTabStaffController extends GetxController {
  final isLoading = false.obs;
  final staffList = RxList<Staff>();

  final textController = TextEditingController();
  final searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    textController.addListener(_onTextUpdate);

    debounce(
      searchText,
      (_) => _search(),
      time: Duration(seconds: 1),
    );
  }

  void _onTextUpdate() {
    // if value is unchanged, return
    if (textController.text == searchText.value) {
      return;
    }

    searchText.value = textController.text;
  }

  void _search() {
    isLoading.value = true;
    searchText.value = textController.text;
    Future.delayed(Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
