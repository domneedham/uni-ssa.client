import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/utils/manager_category_form_constants.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/utils/manager_skill_form_constants.dart';

class ManagerCategoryFormController extends GetxController {
  final categoryRepository = Get.find<CategoryRepository>();

  final parameters = Get.parameters;
  final arguments = Get.arguments;

  var formMode = ManagerCategoryFormMode.ADD;
  Category? editCategory;

  final isLoading = false.obs;
  final isError = false.obs;
  final error = "".obs;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _selectedIcon = Rx(Icons.code);
  IconData get selectedIcon => _selectedIcon.value;
  set selectedIcon(IconData? value) {
    if (value != null) _selectedIcon.value = value;
  }

  @override
  void onInit() async {
    super.onInit();
    _getParameters();
  }

  void _getParameters() {
    if (parameters[ManagerSkillFormConstants.MODE] != null) {
      if (parameters[ManagerSkillFormConstants.MODE] ==
          ManagerSkillFormConstants.EDIT) {
        formMode = ManagerCategoryFormMode.EDIT;
        _getEditArguments();
      } else {
        formMode = ManagerCategoryFormMode.ADD;
      }
    }
  }

  void _getEditArguments() {
    if (arguments?[ManagerCategoryFormConstants.EDIT_MODE_CATEGORY_ARGUMENT] !=
        null) {
      final category =
          arguments[ManagerCategoryFormConstants.EDIT_MODE_CATEGORY_ARGUMENT]
              as Category;
      editCategory = category;
      selectedIcon = category.icon;
    }
  }

  pickIcon() async {
    final icon = await FlutterIconPicker.showIconPicker(Get.context!,
        iconPackMode: IconPack.material);

    selectedIcon = icon;
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

enum ManagerCategoryFormMode { ADD, EDIT }
