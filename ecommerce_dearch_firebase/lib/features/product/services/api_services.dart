import 'dart:convert';

import 'package:ecommerce_dearch_firebase/features/product/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static Future<List<ProductDataModel>> fetchProduct() async {
    const urlString = "https://fakestoreapi.com/products";
    final url = Uri.parse(urlString);
    final response = await http.get(url);
    final jsonBody = jsonDecode(response.body);
    final result = jsonBody as List<dynamic>;
    final transformed = result.map((toElement) {
      final rating = Rating(
          rate: (toElement['rating']['rate'] as num).toDouble(),
          count: toElement['rating']['count']);
      return ProductDataModel(
          id: toElement['id'],
          title: toElement['title'],
          price: (toElement['price'] as num).toDouble(),
          description: toElement['description'],
          category: categoryValues.map[toElement['category']]!,
          image: toElement['image'],
          rating: rating);
    }).toList();
    return transformed;
  }
}
