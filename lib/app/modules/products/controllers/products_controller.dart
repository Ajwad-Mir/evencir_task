import 'package:evencir_task/app/models/products_model.dart';
import 'package:evencir_task/app/repositories/product_repository.dart';
import 'package:evencir_task/app/services/favorite_items_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final isLoading = false.obs;
  final products = <ProductsModel>[].obs;
  final filteredProducts = <ProductsModel>[].obs;
  final selectedProduct = ProductsModel.empty().obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    isLoading.value = true;
    products.addAll(await ProductRepository.getAllProducts());
    isLoading.value = false;
  }

  void handleFavoriteProduct(ProductsModel product) {

    if(Get.find<FavoriteItemService>().favoriteProducts.contains(product)) {
      Get.find<FavoriteItemService>().removeItemFromFavorites(product);
      return;
    }
    Get.find<FavoriteItemService>().addItemToFavorites(product);
  }

  Future<void> getProductFromID(String productId) async{
    selectedProduct.value =  await ProductRepository.getProductFromId(productId);
  }
}