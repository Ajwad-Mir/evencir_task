import 'package:evencir_task/app/modules/categories/controllers/categories_controller.dart';
import 'package:evencir_task/app/modules/favorites/controllers/favories_controller.dart';
import 'package:evencir_task/app/modules/products/controllers/products_controller.dart';
import 'package:evencir_task/app/modules/profile/controllers/profile_controller.dart';
import 'package:evencir_task/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:evencir_task/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => ProductsController(), fenix: true);
    Get.lazyPut(() => CategoriesController(), fenix: true);
    Get.lazyPut(() => FavoritesController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
