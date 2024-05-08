import 'dart:developer';
import 'package:http/http.dart' as http;

import '../config/app_constants.dart';

class MovieRatingRepo {
  Future<void> giveMovieRatingWithGuest(
    int movieId,
    double rating,
    String guestId,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/rating?guest_session_id=$guestId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json;charset=utf-8',
        },
        body: {
          "value": rating,
        },
      );
      if (response.statusCode == 200) {
        log("Rating given successfully");
      } else {
        log("Failed to give rating");
      }
    } catch (e) {
      log("Outer Exception, Failed to give rating: ${e.toString()}");
    }
  }
}
