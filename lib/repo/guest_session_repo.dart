import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:netflix/models/For%20APIs/guest_session_model.dart';

import '../config/app_constants.dart';

class GuestSessionRepo {
  //----------------------------------Fetching Movie Details-------------------------------------
  Future<GuestSessionModel> generateGuestSession() async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/authentication/guest_session/new",
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        GuestSessionModel guestSessionModel =
            guestSessionModelFromJson(response.body.toString());
        return guestSessionModel;
      } else {
        throw Exception("Failed to generate guest session");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Outer Exception: Failed to generate guest session");
  }
}
