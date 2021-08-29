import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_edit_details_controller.dart';
import 'package:ssa_app/app/ui/staff_edit_details_page/staff_edit_details_page.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

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
        final userService = TestMocks.userService;

        when(userService.user).thenReturn(staffOne);

        final controller = Get.find<StaffEditDetailsController>();

        final response = controller.validateName('Name');
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final userService = TestMocks.userService;

        when(userService.user).thenReturn(staffOne);

        final controller = Get.find<StaffEditDetailsController>();

        final response = controller.validateName(null);
        expect(response, isNotNull);
      });
    });
  });

  group('save method', () {
    testWidgets('should call save if form is valid', (tester) async {
      final userService = TestMocks.userService;

      when(userService.user).thenReturn(staffOne);
      when(userService.updateStaffDetails(any))
          .thenAnswer((_) async => staffOne);

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: StaffEditDetailsPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<StaffEditDetailsController>();
      controller.firstnameController.text = 'Hello';
      controller.surnameController.text = 'World';

      await controller.save();
      // let the snackbar run
      await tester.pump(const Duration(seconds: 5));

      verify(userService.updateStaffDetails(any)).called(1);
    });

    testWidgets('should not call save if firstname is not valid',
        (tester) async {
      final userService = TestMocks.userService;

      when(userService.user).thenReturn(staffOne);
      when(userService.updateStaffDetails(any))
          .thenAnswer((_) async => staffOne);

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: StaffEditDetailsPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<StaffEditDetailsController>();
      // make invalid state
      controller.firstnameController.text = '';
      controller.surnameController.text = 'World';

      await controller.save();
      // let the snackbar run
      await tester.pump(const Duration(seconds: 5));

      verifyNever(userService.updateStaffDetails(any));
    });

    testWidgets('should not call save if surname is not valid', (tester) async {
      final userService = TestMocks.userService;

      when(userService.user).thenReturn(staffOne);
      when(userService.updateStaffDetails(any))
          .thenAnswer((_) async => staffOne);

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: StaffEditDetailsPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<StaffEditDetailsController>();
      // make invalid state
      controller.firstnameController.text = 'Hello';
      controller.surnameController.text = '';

      await controller.save();
      // let the snackbar run
      await tester.pump(const Duration(seconds: 5));

      verifyNever(userService.updateStaffDetails(any));
    });
  });
}
