import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';

class CategoryRepository {
  final categoryOne = Category(id: 1, name: "Code", icon: Icons.code);
  final categoryTwo = Category(id: 5, name: "People", icon: Icons.people);

  List<Category> get _categories => [categoryOne, categoryTwo];

  Future<Category> getCategoryById(int id) async {
    return await Future.delayed(Duration(seconds: 1), () {
      return _categories.firstWhere((element) => element.id == id);
    });
  }

  Future<List<Category>> get categories async {
    return await Future.delayed(Duration(seconds: 2), () {
      // throw NoDataReturned("No data returned from the server");
      return _categories;
    });
  }
}
