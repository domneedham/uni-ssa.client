import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class ManagerStaffTabController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;

  final userRepo = Get.find<UserRepository>();

  final isLoading = false.obs;
  final isError = false.obs;
  final error = "".obs;

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
    isError.value = false;
    error.value = "";
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

    try {
      isError.value = false;
      error.value = "";

      if (tabControllerStatus == ManagerStaffTabControllerStatus.STAFF) {
        await _searchStaff();
      } else {
        await _searchManager();
      }
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _searchStaff() async {
    final tempList = await userRepo.searchStaffByName(searchText.value);
    staffList.value = tempList;
  }

  Future<void> _searchManager() async {
    final tempList = await userRepo.searchManagerByName(searchText.value);
    managerList.value = tempList;
  }

  void navigateToUserOverview(int? id) {
    if (id == null) {
      Get.snackbar(
          "Error", "The user has not loaded correctly. Please try again");
      return;
    }

    final sid = id.toString();
    final parameters = {"id": sid};

    if (tabControllerStatus == ManagerStaffTabControllerStatus.STAFF) {
      Get.toNamed(Routes.STAFF_OVERVIEW, parameters: parameters);
    } else {
      Get.toNamed(Routes.MANAGER_OVERVIEW, parameters: parameters);
    }
  }
}

enum ManagerStaffTabControllerStatus {
  STAFF,
  MANAGER,
}
