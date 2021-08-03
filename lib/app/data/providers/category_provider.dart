import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/exceptions/failed_to_update.dart';

abstract class ICategoryProvider {
  Future<Response<List<Category>>> getAllCategories();
  Future<Response<Category>> getCategoryById(int id);
  Future<Category> createCategory(Category category);
  Future<Category> updateCategory(Category category);
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

  String _encodeNewCategory(Category category) {
    return jsonEncode({
      "name": category.name,
      "icon": category.icon.codePoint,
    });
  }

  String _encodeEditCategory(Category category) {
    return jsonEncode({
      "id": category.id,
      "name": category.name,
      "icon": category.icon.codePoint,
    });
  }

  @override
  Future<Response<List<Category>>> getAllCategories() {
    return get('/', decoder: (val) => _decodeCategoryList(val));
  }

  @override
  Future<Response<Category>> getCategoryById(int id) {
    return get('/$id', decoder: (val) => _decodeCategory(val));
  }

  @override
  Future<Category> createCategory(Category category) async {
    final encodedCategory = _encodeNewCategory(category);
    final res = await post('/create', encodedCategory);

    if (res.hasError) {
      throw FailedToUpdateCategoryException("Failed to update category");
    }

    return _decodeCategory(res.body);
  }

  @override
  Future<Category> updateCategory(Category category) async {
    final encodedCategory = _encodeEditCategory(category);
    final res = await put('/update', encodedCategory);

    if (res.hasError) {
      throw FailedToUpdateCategoryException("Failed to update category");
    }

    return category;
  }
}
