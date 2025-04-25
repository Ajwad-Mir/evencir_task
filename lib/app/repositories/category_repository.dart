import 'dart:convert';
import 'dart:io';
import 'package:evencir_task/app/models/categories_model.dart';
import 'package:evencir_task/app/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {

  CategoryRepository._();

  static Future<List<CategoriesModel>> getCategories() async {
    try{
      final response = await http.get(
          Uri.parse("https://dummyjson.com/products/categories"),
          headers: {
            "Content-Type": "application/json",
          }
      );
      if(response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final categories = jsonResponse as List;
        return categories.map((element) => CategoriesModel.fromJson(element)).toList();
      }
      return <CategoriesModel>[];
    } on HttpException catch (e) {
      debugPrint(e.message);
      return <CategoriesModel>[];
    }
  }

  static Future<List<ProductsModel>> getProductByCategoryName({required String name}) async{
    try{
      final response = await http.get(
          Uri.parse("https://dummyjson.com/products/category/$name"),
          headers: {
            "Content-Type": "application/json",
          }
      );
      if(response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final productsJson = jsonResponse['products'] as List;
        return productsJson.map((element) => ProductsModel.fromJson(element)).toList();
      }
      return <ProductsModel>[];
    } on HttpException catch (e) {
      debugPrint(e.message);
      return <ProductsModel>[];
    }
  }
}