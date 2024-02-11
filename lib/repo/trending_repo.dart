// class ProductsRepo {
//   Future<List<ProductModel>> getProducts() async {
//     var response =
//         await http.get(Uri.parse("https://fakestoreapi.com/products"));

//     if (response.statusCode == 200) {
//       return productModelFromJson(response.body);
//     } else {
//       throw Exception("Failed to Load Products");
//     }
//   }
// }

import 'dart:developer';

import '../config/app_constants.dart';
import '../models/trending_people_model.dart';
import 'package:http/http.dart' as http;

class TrendingRepo {
  Future<TrendingMovieModel> fetchTrendingMovies() async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://api.themoviedb.org/3/trending/movie/day?language=en-US"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final trendingMovieModel =
            trendingMovieModelFromJson(response.body.toString());
        return trendingMovieModel;
      } else {
        throw Exception("Failed to Load Trending Movies");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Outer Exception: Failed to Load Trending Movies");
  }
}
