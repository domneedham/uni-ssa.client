import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/home_staff.controller.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final mockUserStaff = User(id: 1, name: "DN", userRole: UserRole.STAFF);
  final mockUserManager = User(id: 2, name: "DN", userRole: UserRole.MANAGER);

  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeStaffController>(() => HomeStaffController());
  });

  setUp(() async {
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  testWidgets('Staff home page is displayed if the user is staff',
      (WidgetTester tester) async {
    final mockRepo = TestMocks.userRepository;

    when(mockRepo.user).thenReturn(mockUserStaff);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(find.text(mockUserStaff.userDebugInfo), findsOneWidget);
    expect(find.text(mockUserManager.userDebugInfo), findsNothing);
  });

  testWidgets('Manager home page is displayed if user is manager',
      (WidgetTester tester) async {
    final mockRepo = TestMocks.userRepository;

    when(mockRepo.user).thenReturn(mockUserManager);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(find.text(mockUserStaff.userDebugInfo), findsNothing);
    expect(find.text(mockUserManager.userDebugInfo), findsOneWidget);
  });
}
