import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/exceptions/failed_to_delete.dart';
import 'package:ssa_app/app/exceptions/failed_to_update.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class ICategoryProvider {
  Future<List<Category>> getAllCategories();
  Future<Category> getCategoryById(int id);
  Future<Category> createCategory(Category category);
  Future<Category> updateCategory(Category category);
  Future<void> deleteCategory(int id);
}

class CategoryProvider extends GetConnect implements ICategoryProvider {
  @override
  void onInit() {
    httpClient.baseUrl = '$baseUrl/category';
    httpClient.addRequestModifier(addRequestModifier);
    httpClient.addAuthenticator(addAuthenticator);
    httpClient.maxAuthRetries = 3;
  }

  Category _decodeCategory(Map<String, dynamic> val) {
    return Category.fromJson(val);
  }

  List<Category> _decodeCategoryList(List<dynamic> val) {
    return List<Category>.from(
      val.map(
        (x) => Category.fromJson(x),
      ),
    );
  }

  String _encodeNewCategory(Category category) {
    return jsonEncode({
      'name': category.name,
      'icon': category.icon.codePoint,
    });
  }

  String _encodeEditCategory(Category category) {
    return jsonEncode({
      'id': category.id,
      'name': category.name,
      'icon': category.icon.codePoint,
    });
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final res = await get('/');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Not categories found');
    }

    return _decodeCategoryList(res.body!);
  }

  @override
  Future<Category> getCategoryById(int id) async {
    final res = await get('/$id');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Category not found');
    }

    return _decodeCategory(res.body!);
  }

  @override
  Future<Category> createCategory(Category category) async {
    final encodedCategory = _encodeNewCategory(category);
    final res = await post('/create', encodedCategory);

    if (res.hasError) {
      throw FailedToUpdateCategoryException('Failed to update category');
    }

    return _decodeCategory(res.body);
  }

  @override
  Future<Category> updateCategory(Category category) async {
    final encodedCategory = _encodeEditCategory(category);
    final res = await put('/update', encodedCategory);

    if (res.hasError) {
      throw FailedToUpdateCategoryException('Failed to update category');
    }

    return category;
  }

  @override
  Future<void> deleteCategory(int id) async {
    final res = await delete('/delete/$id');

    if (res.hasError) {
      throw FailedToDeleteCategoryException('Failed to delete category');
    }
  }
}
