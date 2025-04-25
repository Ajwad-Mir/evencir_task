import 'package:evencir_task/app/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {

  final isCategoriesLoading = false.obs;
  final isProductLoading = false.obs;
  final products = [].obs;
  final filteredProducts = [].obs;
  final categories = [].obs;
  final filteredCategories = [].obs;
  final selectedCategory = ''.obs;
  final categoriesSearchController = TextEditingController();
  final productSearchCategories = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    isCategoriesLoading.value = true;
    categories.addAll(await CategoryRepository.getCategories());
    isCategoriesLoading.value = false;
  }

  Future<void> getProductBySelectedCategory() async {
    isProductLoading.value = true;
    products.addAll(await CategoryRepository.getProductByCategoryName(name: selectedCategory.value));
    isProductLoading.value = false;
  }
}