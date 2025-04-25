import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/products_model.dart';
class ProductRepository {
  ProductRepository._();

  static Future<List<ProductsModel>> getAllProducts() async{
    try{
      final response = await http.get(
          Uri.parse("https://dummyjson.com/products?limit=100"),
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


  static Future<ProductsModel> getProductFromId(String productID) async{
    try{
      final response = await http.get(
          Uri.parse("https://dummyjson.com/products/$productID"),
          headers: {
            "Content-Type": "application/json",
          }
      );
      if(response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ProductsModel.fromJson(jsonResponse);
      }
      return ProductsModel.empty();
    } on HttpException catch (e) {
      debugPrint(e.message);
      return ProductsModel.empty();
    }
  }

  // https://dummyjson.com/products/categories

}