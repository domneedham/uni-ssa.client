import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/providers/category_provider.dart';

class CategoryRepository {
  CategoryRepository({required this.categoryProvider});
  final ICategoryProvider categoryProvider;

  Future<Category> getCategoryById(int id) async {
    final res = await categoryProvider.getCategoryById(id);
    return res.body!;
  }

  Future<List<Category>> get categories async {
    final res = await categoryProvider.getAllCategories();
    return res.body!;
  }
}
