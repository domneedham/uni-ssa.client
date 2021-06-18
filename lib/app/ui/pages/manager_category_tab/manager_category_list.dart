import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';

import 'manager_category_list_tile.dart';

class ManagerCategoryList extends GetView<ManagerCategoryTabController> {
  const ManagerCategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.categories!.length,
      itemBuilder: (context, pos) {
        final item = controller.categories![pos];
        return ManagerCategoryListTile(
          item: item,
          onPressed: () => controller.navigateToCategoryEdit(item),
        );
      },
    );
  }
}
