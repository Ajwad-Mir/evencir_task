import 'package:evencir_task/app/models/products_model.dart';
import 'package:get/get.dart';

class FavoriteItemService extends GetxService {

  final favoriteProducts = <ProductsModel>[].obs;
  final RxSet<int> favoriteIds = <int>{}.obs; // just to check favorite status easily


  void addItemToFavorites(ProductsModel product) {

    favoriteIds.add(product.id);
    favoriteProducts.add(product);
  }

  void removeItemFromFavorites(ProductsModel product) {
    favoriteIds.remove(product.id);
    favoriteProducts.removeWhere((p) => p.id == product.id);
  }

  bool isFavorite(int id) => favoriteIds.contains(id);

}