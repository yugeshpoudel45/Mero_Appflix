import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:netflix/models/For%20APIs/movie_search_model.dart';
import 'package:netflix/models/For%20APIs/people_search_model.dart';
import 'package:netflix/models/For%20APIs/tvShow_search_model.dart';

import '../config/app_constants.dart';

class SearchRepo {
  Future<MovieSearchModel> fetchSearchMovies(
    String movieName,
    bool includeAdult,
    int releaseYear,
  ) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/search/movie?query=$movieName&include_adult=$includeAdult&primary_release_year=$releaseYear&page=1",
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        MovieSearchModel movieSearchModel =
            movieSearchModelFromJson(response.body);
        return movieSearchModel;
      } else {
        throw Exception("Failed to Load Search Movies");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Please relaunch the app :   Failed to Load Search Movies");
  }

  Future<TvShowSearchModel> fetchSearchTvShow(
    String tvShowName,
    bool includeAdult,
    int releaseYear,
  ) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/search/tv?query=$tvShowName&first_air_date_year=$releaseYear&include_adult=$includeAdult&page=1",
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        TvShowSearchModel tvShowSearchModel =
            tvShowSearchModelFromJson(response.body);
        return tvShowSearchModel;
      } else {
        throw Exception("Failed to Load Tv Search Shows");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to Load Search Tv Shows");
  }

  Future<PeopleSearchModel> fetchSearchPeople(
    String peopleName,
    bool includeAdult,
  ) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/search/person?query=$peopleName&include_adult=$includeAdult&page=1",
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        PeopleSearchModel peopleSearchModel =
            peopleSearchModelFromJson(response.body);
        return peopleSearchModel;
      } else {
        throw Exception("Failed to Load Search People");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Please relaunch the app :   Failed to Load Search People");
  }
}
