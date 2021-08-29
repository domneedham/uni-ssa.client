import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_overview_controller.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

void main() {
  final managerOne = TestData.mockManagerWithStaff;
  final staffOne = TestData.mockStaffWithExpirySkills;

  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerOverviewController>(() => ManagerOverviewController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('get user function', () {
    test('sets the user correctly if found', () async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.getManagerById(1))
          .thenAnswer((_) async => managerOne);

      Get.parameters = {'id': '1'};

      final controller = Get.find<ManagerOverviewController>();

      await controller.getUser('1');

      expect(controller.manager?.value, managerOne);
    });

    test('sets an error if the manager data was not loaded', () async {
      final mockUserService = TestMocks.userService;

      final error = Exception('Some error');

      when(mockUserService.getManagerById(1))
          .thenAnswer((_) async => throw error);

      Get.parameters = {'id': '1'};

      final controller = Get.find<ManagerOverviewController>();

      await controller.getUser('1');

      expect(controller.isError.value, true);
      expect(controller.error.value, error.toString());
    });
  });

  group('get staff by id function', () {
    test('calls the user repository get staff by id method', () async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.getManagerById(1))
          .thenAnswer((_) async => managerOne);
      when(mockUserService.getStaffById(1)).thenAnswer((_) async => staffOne);

      Get.parameters = {'id': '1'};

      final controller = Get.find<ManagerOverviewController>();

      await controller.getStaffById(1);

      verify(mockUserService.getStaffById(1)).called(1);
    });

    test('returns the right staff member', () async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.getManagerById(1))
          .thenAnswer((_) async => managerOne);
      when(mockUserService.getStaffById(1)).thenAnswer((_) async => staffOne);

      Get.parameters = {'id': '1'};

      final controller = Get.find<ManagerOverviewController>();

      final value = await controller.getStaffById(1);

      expect(value, staffOne);
    });
  });
}
