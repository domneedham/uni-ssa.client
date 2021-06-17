import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/repository/categories_repository.dart';

class ManagerCategoriesTabController extends GetxController {
  final catRepo = Get.find<CategoriesRepository>();

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
}
