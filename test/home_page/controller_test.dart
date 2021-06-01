import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';

class MockController extends Mock implements HomeController {}

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

  test('Increment should add one', () async {
    // recover your controller
    final controller = Get.find<HomeController>();

    // check initial status
    expect(controller.counter.value, 0);

    // await time request
    controller.increment();

    expect(controller.counter.value, 1);
  });

  test('Decrement should subtract one', () async {
    final controller = Get.find<HomeController>();

    // check initial status
    expect(controller.counter.value, 0);

    // await time request
    controller.decrement();

    expect(controller.counter.value, -1);
  });
}
