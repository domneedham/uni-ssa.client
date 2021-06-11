import 'package:get/get.dart';

class StaffController extends GetxController {
  int selectedTab = 0;

  void setSelectedTab(int index) {
    selectedTab = index;
    update();
  }
}
