import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';

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

  testWidgets('Staff home page is displayed if the user is staff',
      (WidgetTester tester) async {
    final mockRepo = TestMocks.userRepository;

    when(mockRepo.user).thenReturn(User(name: "DN", userRole: UserRole.STAFF));

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(find.text('Staff Home Page'), findsOneWidget);
    expect(find.text('Manager Home Page'), findsNothing);
  });

  testWidgets('Manager home page is displayed if user is manager',
      (WidgetTester tester) async {
    final mockRepo = TestMocks.userRepository;

    when(mockRepo.user)
        .thenReturn(User(name: "DN", userRole: UserRole.MANAGER));

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(find.text('Staff Home Page'), findsNothing);
    expect(find.text('Manager Home Page'), findsOneWidget);
  });
}
