import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';

class ManagerCategoryListTile extends GetView<ManagerCategoryTabController> {
  const ManagerCategoryListTile({
    Key? key,
    required this.item,
    required this.edit,
    required this.delete,
  }) : super(key: key);

  final Category item;
  final VoidCallback edit;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.name),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: edit,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: delete,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
