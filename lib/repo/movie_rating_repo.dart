import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:netflix/models/For%20APIs/movie_rating_model.dart';

import '../config/app_constants.dart';

bool isGuest = false;

class MovieRatingRepo {
  //--------------------------For Guest--------------------------
  Future<MovieRatingModel> giveMovieRatingWithGuest(
    int movieId,
    String rating,
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
        },
        body: {
          "value": rating,
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating given successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to give rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Please relaunch the app :   Failed to give Movie Rating");
  }

//--------------------------------------For User--------------------------------------
  Future<MovieRatingModel> giveMovieRatingWithUser(
    int movieId,
    String rating,
    String userId,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/rating?session_id=$userId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
        body: {
          "value": rating,
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating given successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to give rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Please relaunch the app :   Failed to give Movie Rating");
  }

//--------------------------------------Delete Rating For Guest--------------------------------------
  Future<MovieRatingModel> deleteMovieRatingWithGuest(
    int movieId,
    String guestId,
  ) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/rating?guest_session_id=$guestId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating deleted successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to delete rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to delete Movie Rating");
  }

//------------------------Deleting rating for User---------------------------------------
  Future<MovieRatingModel> deleteMovieRatingWithUser(
    int movieId,
    String userId,
  ) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/rating?session_id=$userId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating deleted successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to delete rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to delete Movie Rating");
  }

  //!-------------------------TV Shows-------------------------

  //--------------------------For Guest--------------------------
  Future<MovieRatingModel> giveTvRatingWithGuest(
    int movieId,
    String rating,
    String guestId,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$movieId/rating?guest_session_id=$guestId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
        body: {
          "value": rating,
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating given successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to give rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to give Tv Show Rating");
  }

//--------------------------------------For User--------------------------------------
  Future<MovieRatingModel> giveTvRatingWithUser(
    int movieId,
    String rating,
    String userId,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$movieId/rating?session_id=$userId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
        body: {
          "value": rating,
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating given successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to give rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to give Tv Show Rating");
  }

//--------------------------------------Delete Rating For Guest--------------------------------------
  Future<MovieRatingModel> deleteTvRatingWithGuest(
    int movieId,
    String guestId,
  ) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$movieId/rating?guest_session_id=$guestId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating deleted successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to delete rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to delete Tv Show Rating");
  }

//------------------------Deleting rating for User---------------------------------------
  Future<MovieRatingModel> deleteTvRatingWithUser(
    int movieId,
    String userId,
  ) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$movieId/rating?session_id=$userId",
        ),
        headers: {
          'accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
      );
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        MovieRatingModel movieRatingModel =
            movieRatingModelFromJson(response.body.toString());
        log("Rating deleted successfully");
        return movieRatingModel;
      } else {
        Exception("Failed to delete rating");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to delete Tv Show Rating");
  }
}
