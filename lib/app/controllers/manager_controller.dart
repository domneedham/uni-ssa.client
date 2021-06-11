import 'package:get/get.dart';

class ManagerController extends GetxController {
  int selectedTab = 0;

  void setSelectedTab(int index) {
    selectedTab = index;
    update();
  }
}
