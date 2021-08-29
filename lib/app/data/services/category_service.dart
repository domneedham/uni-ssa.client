import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';

/// Service for interacting with the [CategoryRepository].
class CategoryService {
  CategoryService({
    required this.categoryRepository,
  });
  final ICategoryRepository categoryRepository;

  /// Fetches the category with [id] given.
  Future<Category> getById(int id) {
    return categoryRepository.getById(id);
  }

  /// Fetches all categories that exist.
  Future<List<Category>> getAll() {
    return categoryRepository.getAll();
  }

  /// Creates a new category from the [category] given.
  Future<Category> create(Category category) {
    return categoryRepository.create(category);
  }

  /// Updates the existing category. All information should be already updated
  /// in the [category].
  Future<Category> update(Category category) {
    return categoryRepository.update(category);
  }

  /// Deletes the category and all skills/staff-skills that contain the category.
  Future<void> delete(int id) {
    return categoryRepository.delete(id);
  }
}
