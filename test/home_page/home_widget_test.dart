import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/home_manager_controller.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'manager/manager_home_test_data.dart';
import 'staff/staff_home_test_data.dart';

void main() {
  final mockUserStaff = User(id: 1, name: "DN", userRole: UserRole.STAFF);
  final mockUserManager = User(id: 2, name: "DN", userRole: UserRole.MANAGER);

  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeStaffController>(() => HomeStaffController());
    Get.lazyPut<HomeManagerController>(() => HomeManagerController());
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
    TestMocks.skillStaffRepository;

    when(mockRepo.user).thenReturn(mockUserStaff);
    when(mockRepo.staff).thenReturn(mockStaffOneSkill);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(find.text(mockUserStaff.userDebugInfo), findsOneWidget);
    expect(find.text(mockUserManager.userDebugInfo), findsNothing);
  });

  testWidgets('Manager home page is displayed if user is manager',
      (WidgetTester tester) async {
    final mockRepo = TestMocks.userRepository;
    TestMocks.skillManagerRepository;

    when(mockRepo.user).thenReturn(mockUserManager);
    when(mockRepo.manager).thenReturn(mockManager);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(find.text(mockUserManager.userDebugInfo), findsOneWidget);
    expect(find.text(mockUserStaff.userDebugInfo), findsNothing);
  });
}
