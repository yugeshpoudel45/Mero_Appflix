import 'dart:developer';

import 'package:netflix/models/trending_people_model.dart';
import 'package:netflix/models/trending_tv_show.dart';

import '../config/app_constants.dart';
import '../models/trending_movie_model.dart';
import 'package:http/http.dart' as http;

class TrendingRepo {
  //------------------------------------------Trending Movie Fetching--------------------------------------------
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
        // final meroBody = jsonDecode(response.body);

        TrendingMovieModel? trendingMovieModel =
            trendingMovieModelFromJson(response.body);
        return trendingMovieModel;
      } else {
        throw Exception("Failed to Load Trending Movies");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Outer Exception: Failed to Load Trending Movies");
    // return null;
  }

//------------------------------------------Trending People Fetching--------------------------------------------
  Future<TrendingPeopleModel> fetchTrendingPeople() async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://api.themoviedb.org/3/trending/person/day?language=en-US"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        TrendingPeopleModel trendingPeopleModel =
            trendingPeopleModelFromJson(response.body.toString());
        return trendingPeopleModel;
      } else {
        throw Exception("Failed to Load Trending People");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Outer Exception: Failed to Load Trending People");
  }

//------------------------------------------Trending Tv Shows Fetching--------------------------------------------
  Future<TrendingTvShowModel> fetchTrendingTvShows() async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://api.themoviedb.org/3/trending/tv/day?language=en-US"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        TrendingTvShowModel trendingTvShowModel =
            trendingTvShowModelFromJson(response.body.toString());
        return trendingTvShowModel;
      } else {
        throw Exception("Failed to Load Trending TV Shows");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Outer Exception: Failed to Load Trending TV Shows");
  }
}
