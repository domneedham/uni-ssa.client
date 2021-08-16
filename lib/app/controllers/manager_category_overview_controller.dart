import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';

class ManagerCategoryOverviewController extends GetxController {
  final catRepo = Get.find<CategoryRepository>();

  final isLoading = false.obs;
  final isError = false.obs;
  final error = "".obs;
  Rx<Category>? category = Rx(Get.arguments["category"]);

  final parameters = Get.parameters;

  @override
  void onInit() async {
    super.onInit();
    if (category == null) {
      await getCategory(parameters["id"]!);
    }
  }

  @override
  void onClose() {
    super.onClose();
    ManagerCategoryTabController.to.refresh();
  }

  Future<void> getCategory(String id) async {
    try {
      isLoading.value = true;
      int parsedId = int.parse(id);
      Category fetchedCategory = await catRepo.getCategoryById(parsedId);
      category = fetchedCategory.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
