import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/login_controller.dart';
import 'package:ssa_app/app/ui/pages/login/login_page.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final userOne = TestData.mockUserStaffOne;

  final binding = BindingsBuilder(() {
    Get.lazyPut<LoginController>(() => LoginController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('validate email', () {
    test('should fail if null', () async {
      TestMocks.userRepository;

      final controller = Get.find<LoginController>();

      final res = controller.validateEmail(null);

      expect(res, "Please enter an email");
    });

    test('should fail if not an email', () async {
      TestMocks.userRepository;

      final controller = Get.find<LoginController>();

      final res = controller.validateEmail("not an email");

      expect(res, "Email is not valid");
    });

    test('should pass if an email', () async {
      TestMocks.userRepository;

      final controller = Get.find<LoginController>();

      final res = controller.validateEmail("test@test.com");

      expect(res, null);
    });
  });

  group('validate password', () {
    test('should fail if null', () async {
      TestMocks.userRepository;

      final controller = Get.find<LoginController>();

      final res = controller.validatePassword(null);

      expect(res, "Please enter a password");
    });

    test('should fail if not longer than 8 characters', () async {
      TestMocks.userRepository;

      final controller = Get.find<LoginController>();

      final res = controller.validatePassword("sevench");

      expect(res, "Password needs to be 8 characters or more");
    });

    test('should pass if a password', () async {
      TestMocks.userRepository;

      final controller = Get.find<LoginController>();

      final res = controller.validatePassword("eightchr");

      expect(res, null);
    });
  });

  group('login', () {
    testWidgets('login should call login email password if valid',
        (tester) async {
      final mockRepo = TestMocks.userRepository;

      when(mockRepo.loginEmailPassword(any, any))
          .thenAnswer((_) async => userOne);

      // pump to init form key
      await tester.pumpWidget(TestableWidget(child: LoginPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<LoginController>();

      controller.emailController.text = "test@test.com";
      controller.passwordController.text = "password";

      await controller.login();

      verify(mockRepo.loginEmailPassword(any, any)).called(1);
    });

    testWidgets('login should not call login email password if email not valid',
        (tester) async {
      final mockRepo = TestMocks.userRepository;

      when(mockRepo.loginEmailPassword(any, any))
          .thenAnswer((_) async => userOne);

      // pump to init form key
      await tester.pumpWidget(TestableWidget(child: LoginPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<LoginController>();

      controller.emailController.text = "not an email";
      controller.passwordController.text = "password";

      await controller.login();

      verifyNever(mockRepo.loginEmailPassword(any, any));
    });

    testWidgets(
        'login should not call login email password if password not valid',
        (tester) async {
      final mockRepo = TestMocks.userRepository;

      when(mockRepo.loginEmailPassword(any, any))
          .thenAnswer((_) async => userOne);

      // pump to init form key
      await tester.pumpWidget(TestableWidget(child: LoginPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<LoginController>();

      controller.emailController.text = "test@test.com";
      controller.passwordController.text = "short";

      await controller.login();

      verifyNever(mockRepo.loginEmailPassword(any, any));
    });
  });
}
