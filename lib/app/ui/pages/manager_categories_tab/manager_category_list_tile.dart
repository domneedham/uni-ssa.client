import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_categories_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';

class ManagerCategoryListTile extends GetView<ManagerCategoriesTabController> {
  const ManagerCategoryListTile({
    Key? key,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  final Category item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.name),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.edit),
      ),
    );
  }
}
