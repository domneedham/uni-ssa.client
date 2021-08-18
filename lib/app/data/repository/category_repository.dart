import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/providers/category_provider.dart';

class CategoryRepository {
  CategoryRepository({required this.categoryProvider});
  final ICategoryProvider categoryProvider;

  Future<Category> getCategoryById(int id) {
    return categoryProvider.getCategoryById(id);
  }

  Future<List<Category>> get categories {
    return categoryProvider.getAllCategories();
  }

  Future<Category> createCategory(Category category) {
    return categoryProvider.createCategory(category);
  }

  Future<Category> updateCategory(Category category) {
    return categoryProvider.updateCategory(category);
  }

  Future<void> deleteCategory(int id) {
    return categoryProvider.deleteCategory(id);
  }
}
