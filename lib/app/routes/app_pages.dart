import 'package:get/get.dart';
import 'package:ssa_app/app/bindings/home_binding.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    )
  ];
}
