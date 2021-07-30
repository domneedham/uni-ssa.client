import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';

abstract class ICategoryProvider {
  Future<Response<List<Category>>> getAllCategories();
  Future<Response<Category>> getCategoryById(int id);
}

class CategoryProvider extends GetConnect implements ICategoryProvider {
  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/category";
  }

  Category _decodeCategory(Map<String, dynamic> val) {
    return Category.fromJson(val);
  }

  List<Category> _decodeCategoryList(List<dynamic> val) {
    return List<Category>.from(
      (val).map(
        (x) => Category.fromJson(x),
      ),
    );
  }

  @override
  Future<Response<List<Category>>> getAllCategories() {
    return get('/', decoder: (val) => _decodeCategoryList(val));
  }

  @override
  Future<Response<Category>> getCategoryById(int id) {
    return get('/$id', decoder: (val) => _decodeCategory(val));
  }
}
