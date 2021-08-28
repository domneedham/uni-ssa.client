import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/services/category_service.dart';

class ManagerCategoryOverviewController extends GetxController {
  final catService = Get.find<CategoryService>();

  final isLoading = false.obs;
  final isError = false.obs;
  final error = ''.obs;
  Rx<Category>? category = Rx(Get.arguments['category']);

  final parameters = Get.parameters;

  @override
  void onInit() async {
    super.onInit();
    if (category == null) {
      await getCategory(parameters['id']!);
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
      final int parsedId = int.parse(id);
      final Category fetchedCategory = await catService.getById(parsedId);
      category = fetchedCategory.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
