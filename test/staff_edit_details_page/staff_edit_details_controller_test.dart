import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_edit_details_controller.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';

void main() {
  final staffOne = TestData.mockStaffWithExpirySkills;

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

        when(userRepo.user).thenReturn(staffOne);

        final controller = Get.find<StaffEditDetailsController>();

        final response = controller.validateName("Name");
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final userRepo = TestMocks.userRepository;

        when(userRepo.user).thenReturn(staffOne);

        final controller = Get.find<StaffEditDetailsController>();

        final response = controller.validateName(null);
        expect(response, isNotNull);
      });
    });
  });
}
