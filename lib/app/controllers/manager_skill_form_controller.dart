import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/utils/manager_skill_form_constants.dart';

class ManagerSkillFormController extends GetxController {
  final categoryRepository = Get.find<CategoryRepository>();

  final parameters = Get.parameters;
  final arguments = Get.arguments;

  var formMode = ManagerSkillFormMode.ADD;
  Skill? editSkill;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _categories = RxList<Category>();
  RxList<Category> get categories => _categories;
  final _selectedCategoryId = 0.obs;
  int get selectedCategoryId => _selectedCategoryId.value;
  set selectedCategoryId(int? value) {
    if (value != null) _selectedCategoryId.value = value;
  }

  @override
  void onInit() async {
    super.onInit();
    _getParameters();
    await fetchCategories();
  }

  void _getParameters() {
    if (parameters[ManagerSkillFormConstants.MODE] != null) {
      if (parameters[ManagerSkillFormConstants.MODE] ==
          ManagerSkillFormConstants.EDIT) {
        formMode = ManagerSkillFormMode.EDIT;
        _getEditArguments();
      } else {
        formMode = ManagerSkillFormMode.ADD;
      }
    }
  }

  void _getEditArguments() {
    if (arguments?[ManagerSkillFormConstants.EDIT_MODE_SKILL_ARGUMENT] !=
        null) {
      final skill =
          arguments[ManagerSkillFormConstants.EDIT_MODE_SKILL_ARGUMENT]
              as Skill;
      editSkill = skill;
      selectedCategoryId = skill.category.id;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final cats = await categoryRepository.categories;
      if (cats.isNotEmpty && editSkill == null) {
        selectedCategoryId = cats[0].id;
      }
      _categories.addAll(cats);
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validateCategory(int? value) {
    if (value == null) {
      return 'Please enter some text';
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

enum ManagerSkillFormMode { ADD, EDIT }
