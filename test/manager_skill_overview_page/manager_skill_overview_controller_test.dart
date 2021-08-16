import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_overview_page/manager_skill_overview_page.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final managerOne = TestData.mockManagerWithStaff;
  final skillOne = TestData.mockManagerStaffSkillOne;

  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerSkillOverviewController>(
        () => ManagerSkillOverviewController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('get skill', () {
    test('sets the right skill', () async {
      final skillManagerRepo = TestMocks.skillManagerRepository;
      final userRepo = TestMocks.userRepository;
      TestMocks.skillRepository;

      Get.parameters = {"id": "1"};

      final controller = Get.find<ManagerSkillOverviewController>();

      when(userRepo.user).thenReturn(managerOne);
      when(skillManagerRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      await controller.getSkill("1");

      final testSkill = skillOne;

      final controllerSkill = controller.skill!.value;

      expect(testSkill, controllerSkill);
    });

    test('sets an error if the id can not be found', () async {
      final skillManagerRepo = TestMocks.skillManagerRepository;
      final userRepo = TestMocks.userRepository;
      TestMocks.skillRepository;

      Get.parameters = {"id": "1"};

      final controller = Get.find<ManagerSkillOverviewController>();

      final exception = Exception("Some error");

      when(userRepo.user).thenReturn(managerOne);
      when(skillManagerRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => Future.error(exception));

      await controller.getSkill("1");

      expect(controller.isError.value, true);
      expect(controller.error.value, exception.toString());
    });
  });

  group('delete method', () {
    testWidgets('should call delete', (tester) async {
      final skillManagerRepo = TestMocks.skillManagerRepository;
      final userRepo = TestMocks.userRepository;
      final skillRepo = TestMocks.skillRepository;

      Get.parameters = {"id": "1"};

      when(userRepo.user).thenReturn(managerOne);
      when(skillManagerRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);
      when(skillRepo.delete(1)).thenAnswer((_) async => null);

      // need to pump for snackbar
      await tester
          .pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<ManagerSkillOverviewController>();
      await controller.getSkill("1");

      await controller.deleteSkill();
      // let the snackbar run
      await tester.pumpAndSettle(Duration(seconds: 5));

      verify(skillRepo.delete(1)).called(1);
    });
  });
}
