import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user.dart';

import '../mocks/mocks.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
  });

  setUp(() async {
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  test('Get user should return the user from the repository', () async {
    final mockUserRepo = TestMocks.userRepository;

    final user = User(name: "DN", userRole: UserRole.STAFF);

    when(mockUserRepo.user).thenReturn(user);

    // recover your controller
    final controller = Get.find<HomeController>();

    expect(controller.user, user);
  });
}
