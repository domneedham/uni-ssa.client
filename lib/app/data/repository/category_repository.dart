import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/providers/category_provider.dart';

abstract class ICategoryRepository {
  Future<List<Category>> getAll();
  Future<Category> getById(int id);
  Future<Category> create(Category category);
  Future<Category> update(Category category);
  Future<void> delete(int id);
}

class CategoryRepository implements ICategoryRepository {
  CategoryRepository({
    required this.categoryProvider,
  });
  final ICategoryProvider categoryProvider;

  @override
  Future<Category> getById(int id) {
    return categoryProvider.getCategoryById(id);
  }

  @override
  Future<List<Category>> getAll() {
    return categoryProvider.getAllCategories();
  }

  @override
  Future<Category> create(Category category) {
    return categoryProvider.createCategory(category);
  }

  @override
  Future<Category> update(Category category) {
    return categoryProvider.updateCategory(category);
  }

  @override
  Future<void> delete(int id) {
    return categoryProvider.deleteCategory(id);
  }
}
