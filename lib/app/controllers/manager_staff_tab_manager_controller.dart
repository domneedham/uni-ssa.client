import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class ManagerStaffTabManagerController extends GetxController {
  final userRepo = Get.find<UserRepository>();

  final isLoading = false.obs;
  final managerList = RxList<Manager>();

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
    isLoading.value = true;
    searchText.value = textController.text;
  }

  void _search() async {
    isLoading.value = true;

    searchText.value = textController.text;

    // don't search if empty
    if (searchText.value.isEmpty) {
      managerList.clear();
      isLoading.value = false;
      return;
    }

    final tempList = await userRepo.searchManagerByName(searchText.value);
    managerList.value = tempList;

    isLoading.value = false;
  }
}
