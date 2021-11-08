import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_shopping_app/const/api_const.dart';
import 'package:flutter_shopping_app/model/category.dart';

import 'package:flutter_shopping_app/model/feature_image.dart';
import 'package:flutter_shopping_app/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopping_app/model/banner.dart';

Product parseProductDetail(String responseBody) {
  var l = json.decode(responseBody) as dynamic;
  var product = Product.fromJson(l);
  return product;
}

List<Product> parseProduct(String responseBody) {
  var l = json.decode(responseBody) as List<dynamic>;
  var products = l.map((model) => Product.fromJson(model)).toList();
  return products;
}

List<MyCategory> parseCategory(String responseBody) {
  var l = json.decode(responseBody) as List<dynamic>;
  var categories = l.map((model) => MyCategory.fromJson(model)).toList();
  return categories;
}

List<MyBanner> parseBanner(String responseBody) {
  var l = json.decode(responseBody) as List<dynamic>;
  var banners = l.map((model) => MyBanner.fromJson(model)).toList();
  return banners;
}
List<FeatureImg> parseFeatureImage(String responseBody) {
  var l = json.decode(responseBody) as List<dynamic>;
  var featureImages = l.map((model) => FeatureImg.fromJson(model)).toList();
  return featureImages;
}
Future<List<MyBanner>> fetchBanner() async {
  final response = await http.get(Uri.parse('$mainUrl$bannerUrl'));
  if (response.statusCode == 200)
    return compute(parseBanner, response.body);
   else if (response.statusCode == 404)
      throw Exception('Not found');
  else
    throw Exception('Cannot get Banner');
}

Future<List<FeatureImg>> fetchFeatureImages() async {
  final response = await http.get(Uri.parse('$mainUrl$featureUrl'));
  if (response.statusCode == 200)
    return compute(parseFeatureImage, response.body);
  else if (response.statusCode == 404)
    throw Exception('Not found');
  else
    throw Exception('Cannot get FeatureImg');
}

Future<List<MyCategory>> fetchCategories() async {
  final response = await http.get(Uri.parse('$mainUrl$categoriesUrl'));
  if (response.statusCode == 200)
    return compute(parseCategory, response.body);
  else if (response.statusCode == 404)
    throw Exception('Not found');
  else
    throw Exception('Cannot get Categories');
}

Future<List<Product>> fetchProductBySubCategory(id) async {
  final response = await http.get(Uri.parse('$mainUrl$productUrl/$id'));
  if (response.statusCode == 200)
    return compute(parseProduct, response.body);
  else if (response.statusCode == 404)
    throw Exception('Not found');
  else
    throw Exception('Cannot get Products');
}

Future<Product> fetchProductsDetail(id) async {
  final response = await http.get(Uri.parse('$mainUrl$productDetail/$id'));
  if (response.statusCode == 200)
    return compute(parseProductDetail, response.body);
  else if (response.statusCode == 404)
    throw Exception('Not found');
  else
    throw Exception('Cannot get Product Detail');
}
Future<String> findUser(id, token) async {
  final response = await http.get(Uri.parse('$mainUrl$userPath/$id'),
  headers: {
    'Authorization' : 'Bearer $token'
  });
  if (response.statusCode == 200)
    return 'User found';
  else if (response.statusCode == 404)
    return 'User not found';
  else
    throw Exception('Cannot get User by id');
}