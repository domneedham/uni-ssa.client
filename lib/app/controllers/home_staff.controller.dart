import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class HomeStaffController extends GetxController {
  final UserRepository repo = Get.find<UserRepository>();

  User get user => repo.user;

  final _skills = ["Awesomeness", "Skillz", "To", "Pay", "The", "Bills"].obs;

  RxList<String> get skills => _skills;

  void addItem() => _skills.add("Item");
}
