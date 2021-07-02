import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';

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
    if (parameters["mode"] != null) {
      if (parameters["mode"] == "edit") {
        formMode = ManagerSkillFormMode.EDIT;
        if (arguments["skill"] != null) {
          final skill = arguments["skill"] as Skill;
          editSkill = skill;
          selectedCategoryId = skill.category.id;
        }
      } else {
        formMode = ManagerSkillFormMode.ADD;
      }
    }
    await fetchCategories();
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
