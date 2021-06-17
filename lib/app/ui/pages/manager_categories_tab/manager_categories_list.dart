import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_categories_tab_controller.dart';

class ManagerCategoryList extends GetView<ManagerCategoriesTabController> {
  const ManagerCategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.categories!.length,
      itemBuilder: (context, pos) {
        final item = controller.categories![pos];
        return ListTile(
          leading: Icon(item.icon),
          title: Text(item.name),
          trailing: Icon(Icons.chevron_right),
          onTap: () =>
              controller.navigateToCategoryOverview(item.id, item.name),
        );
      },
    );
  }
}
