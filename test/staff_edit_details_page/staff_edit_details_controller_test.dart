import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_edit_details_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/utils/manager_skill_form_constants.dart';

import '../mocks/mocks.dart';
import 'staff_edit_details_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffEditDetailsController>(() => StaffEditDetailsController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('validate', () {
    group('name', () {
      test('should return null if the name is not null', () async {
        final userRepo = TestMocks.userRepository;

        when(userRepo.user).thenReturn(mockStaff);

        final controller = Get.find<StaffEditDetailsController>();

        final response = controller.validateName("Name");
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final userRepo = TestMocks.userRepository;

        when(userRepo.user).thenReturn(mockStaff);

        final controller = Get.find<StaffEditDetailsController>();

        final response = controller.validateName(null);
        expect(response, isNotNull);
      });
    });
  });
}
