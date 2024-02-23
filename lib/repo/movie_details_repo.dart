import 'dart:developer';

import 'package:http/http.dart' as http;

import '../config/app_constants.dart';
import '../models/For APIs/movie_details_model.dart';

class MoviesDetailsRepo {
  //----------------------------------Fetching Movie Details-------------------------------------
  Future<MovieDetailsModel> fetchMovieDetails(int movieId) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://api.themoviedb.org/3/movie/$movieId?append_to_response=credits%2Creviews%2Csimilar%2Cvideos&language=en-US"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        MovieDetailsModel movieDetailsModel =
            movieDetailsModelFromJson(response.body.toString());
        return movieDetailsModel;
      } else {
        throw Exception("Failed to Load Movie Details");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Outer Exception: Failed to Load Movie Details ");
  }
}
