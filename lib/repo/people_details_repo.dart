import 'dart:developer';

import 'package:http/http.dart' as http;

import '../config/app_constants.dart';
import '../models/For APIs/people_details_model.dart';

class PeopleDetailsRepo {
  //----------------------------------Fetching Tv Show Details-------------------------------------
  Future<PeopleDetailsModel> fetchPeopleDetails(int peopleId) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/person/$peopleId?append_to_response=combined_credits%2Cexternal_ids%2Cimages',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        PeopleDetailsModel peopleDetailsModel =
            peopleDetailsModelFromJson(response.body.toString());
        return peopleDetailsModel;
      } else {
        throw Exception("Failed to Load People Details");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Outer Exception: Failed to Load People Details ");
  }
}
