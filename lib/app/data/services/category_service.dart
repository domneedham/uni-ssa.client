import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';

class CategoryService {
  CategoryService({required this.categoryRepository});
  final CategoryRepository categoryRepository;

  Future<Category> getCategoryById(int id) {
    return categoryRepository.getCategoryById(id);
  }

  Future<List<Category>> get categories {
    return categoryRepository.categories;
  }

  Future<Category> createCategory(Category category) {
    return categoryRepository.createCategory(category);
  }

  Future<Category> updateCategory(Category category) {
    return categoryRepository.updateCategory(category);
  }

  Future<void> deleteCategory(int id) {
    return categoryRepository.deleteCategory(id);
  }
}
