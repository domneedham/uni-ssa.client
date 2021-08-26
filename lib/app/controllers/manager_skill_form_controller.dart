import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/services/category_service.dart';
import 'package:ssa_app/app/data/services/skill_service.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/utils/manager_skill_form_constants.dart';

class ManagerSkillFormController extends GetxController {
  final categoryService = Get.find<CategoryService>();
  final skillService = Get.find<SkillService>();

  final parameters = Get.parameters;
  final arguments = Get.arguments;

  var formMode = ManagerSkillFormMode.ADD;
  Skill? editSkill;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = ''.obs;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final nameController = TextEditingController();

  final _categories = RxList<Category>();
  RxList<Category> get categories => _categories;

  final _selectedCategoryId = 0.obs;
  int get selectedCategoryId => _selectedCategoryId.value;
  set selectedCategoryId(int? value) {
    if (value != null) {
      _selectedCategoryId.value = value;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    _getParameters();
    await fetchCategories();

    nameController.value = TextEditingValue(text: editSkill?.name ?? '');
  }

  @override
  void onClose() async {
    super.onClose();

    if (formMode == ManagerSkillFormMode.EDIT) {
      ManagerSkillOverviewController.to.update();
    }
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
      final cats = await categoryService.categories;
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

  Future<void> save() async {
    final status = _formKey.currentState?.validate();
    if (status ?? false) {
      try {
        if (formMode == ManagerSkillFormMode.ADD) {
          await _saveNewSkill();
        } else {
          await _saveEditSkill();
        }
        Get.snackbar('Success', 'Skill saved');
      } catch (e) {
        Get.snackbar('Update failed', e.toString());
      }
    } else {
      Get.snackbar('Terrible', 'Forms looking not so good');
    }
  }

  Future<void> _saveNewSkill() async {
    final selectedCategory =
        categories.firstWhere((element) => element.id == selectedCategoryId);

    final skill = Skill(
      id: -1,
      category: selectedCategory,
      name: nameController.value.text,
    );
    await skillService.create(skill);
  }

  Future<void> _saveEditSkill() async {
    final selectedCategory =
        categories.firstWhere((element) => element.id == selectedCategoryId);

    final skill = Skill(
      id: editSkill!.id,
      category: selectedCategory,
      name: nameController.value.text,
    );
    await skillService.update(skill);
  }
}

enum ManagerSkillFormMode { ADD, EDIT }
