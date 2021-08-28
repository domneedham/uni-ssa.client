import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';

class CategoryService {
  CategoryService({
    required this.categoryRepository,
  });
  final ICategoryRepository categoryRepository;

  Future<Category> getById(int id) {
    return categoryRepository.getById(id);
  }

  Future<List<Category>> getAll() {
    return categoryRepository.getAll();
  }

  Future<List<Category>> get categories {
    return categoryRepository.getAll();
  }

  Future<Category> create(Category category) {
    return categoryRepository.create(category);
  }

  Future<Category> update(Category category) {
    return categoryRepository.update(category);
  }

  Future<void> delete(int id) {
    return categoryRepository.delete(id);
  }
}
