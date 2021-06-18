import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class ManagerStaffTabController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;

  final userRepo = Get.find<UserRepository>();

  final isLoading = false.obs;
  final managerList = RxList<Manager>();
  final staffList = RxList<Staff>();

  final textController = TextEditingController();
  final searchText = "".obs;

  ManagerStaffTabControllerStatus get tabControllerStatus {
    return tabController?.index == 0
        ? ManagerStaffTabControllerStatus.STAFF
        : ManagerStaffTabControllerStatus.MANAGER;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(_onTabChange);

    textController.addListener(_onTextUpdate);
    debounce(
      searchText,
      (_) => _search(),
      time: Duration(seconds: 1),
    );
  }

  @override
  void onClose() {
    super.onClose();
    if (tabController != null) {
      tabController!.dispose();
    }
    textController.dispose();
  }

  void _onTabChange() {
    textController.clear();
    isLoading.value = false;
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
      staffList.clear();
      isLoading.value = false;
      return;
    }

    if (tabControllerStatus == ManagerStaffTabControllerStatus.STAFF) {
      await _searchStaff();
    } else {
      await _searchManager();
    }

    isLoading.value = false;
  }

  Future<void> _searchStaff() async {
    final tempList = await userRepo.searchStaffByName(searchText.value);
    staffList.value = tempList;
  }

  Future<void> _searchManager() async {
    final tempList = await userRepo.searchManagerByName(searchText.value);
    managerList.value = tempList;
  }
}

enum ManagerStaffTabControllerStatus {
  STAFF,
  MANAGER,
}
