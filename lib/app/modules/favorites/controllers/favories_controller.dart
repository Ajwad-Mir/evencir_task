import 'package:evencir_task/app/models/products_model.dart';
import 'package:evencir_task/app/services/favorite_items_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final filteredFavorites = <ProductsModel>[];
  final favoriteSearchController = TextEditingController();

  void handleFavoriteProduct(ProductsModel product) {

    if(Get.find<FavoriteItemService>().favoriteProducts.contains(product)) {
      Get.find<FavoriteItemService>().removeItemFromFavorites(product);
      return;
    }
    Get.find<FavoriteItemService>().addItemToFavorites(product);
  }
}