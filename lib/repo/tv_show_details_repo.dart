import 'dart:developer';

import 'package:http/http.dart' as http;

import '../config/app_constants.dart';
import '../models/For APIs/tv_show_details_model.dart';

class TvShowDetailsRepo {
  //----------------------------------Fetching Tv Show Details-------------------------------------
  Future<TvShowDetailsModel> fetchTvShowDetails(int tvShowId) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$tvShowId?append_to_response=credits%2Creviews%2Csimilar%2Cvideos",
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        TvShowDetailsModel tvShowDetailsModel =
            tvShowDetailsModelFromJson(response.body.toString());
        return tvShowDetailsModel;
      } else {
        throw Exception("Failed to Load Tv Show Details");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception(
        "Please relaunch the app :   Failed to Load Tv Show Details ");
  }
}
