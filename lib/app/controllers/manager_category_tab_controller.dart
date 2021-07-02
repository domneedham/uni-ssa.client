import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/utils/manager_category_form_constants.dart';

class ManagerCategoryTabController extends GetxController {
  final catRepo = Get.find<CategoryRepository>();

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  RxList<Category>? categories;

  @override
  onInit() async {
    super.onInit();
    await getCategories();
  }

  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      final repoSkills = await catRepo.categories;
      categories = repoSkills.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToCategoryEdit(Category category) {
    final parameters = {
      ManagerCategoryFormConstants.MODE: ManagerCategoryFormConstants.EDIT
    };
    final arguments = {
      ManagerCategoryFormConstants.EDIT_MODE_CATEGORY_ARGUMENT: category
    };

    Get.toNamed(
      Routes.MANAGER_CATEGORY_FORM,
      parameters: parameters,
      arguments: arguments,
    );
  }

  void addNewCategory() {
    final parameters = {
      ManagerCategoryFormConstants.MODE: ManagerCategoryFormConstants.ADD
    };
    Get.toNamed(Routes.MANAGER_CATEGORY_FORM, parameters: parameters);
  }
}
