import 'package:evencir_task/app/modules/categories/pages/categories_page.dart';
import 'package:evencir_task/app/modules/favorites/pages/favorites_page.dart';
import 'package:evencir_task/app/modules/products/pages/products_page.dart';
import 'package:evencir_task/app/modules/profile/pages/profile_page.dart';
import 'package:evencir_task/generated/assets.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final Map<String,String> navBarItems = <String,String>{
    Assets.svgProductsNavBar : "Products",
    Assets.svgCategoriesNavBar : "Categories",
    Assets.svgFavoritesNavBar : "Favourites",
    Assets.svgProfileNavBar : "Mitt Konto",
  };

  final tabs = [
    ProductsPage(),
    CategoriesPage(),
    FavoritesPage(),
    ProfilePage()
  ];

}