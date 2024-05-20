import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:netflix/models/For%20APIs/auth/login_session_model.dart';

import '../../config/app_constants.dart';

class LoginSessionRepo {
  //----------------------------------Fetching Movie Details-------------------------------------
  Future<LoginSessionModel> generateLoginSession(
    String username,
    String password,
  ) async {
    String requestTokenUrl =
        "https://api.themoviedb.org/3/authentication/token/new";
    String validateRequestTokenUrl =
        "https://api.themoviedb.org/3/authentication/token/validate_with_login";
    String createSessionIdUrl =
        "https://api.themoviedb.org/3/authentication/session/new";
    String requestToken = "";
    String newRequestToken = "";
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      //------------------------------Generate request token---------------------

      http.Response requestTokenResponse = await http.get(
        Uri.parse(
          requestTokenUrl,
        ),
        headers: headers,
      );
      if (requestTokenResponse.statusCode == 200) {
        requestToken = jsonDecode(requestTokenResponse.body)['request_token'];
      } else {
        throw Exception("Failed to generate request token");
      }

      //------------------------------Validate the request token with login---------------------
      http.Response validateTokenResponse = await http.post(
          Uri.parse(
            validateRequestTokenUrl,
          ),
          headers: headers,
          body: {
            "username": username,
            "password": password,
            "request_token": requestToken,
          });
      if (validateTokenResponse.statusCode == 200) {
        newRequestToken =
            jsonDecode(validateTokenResponse.body)['request_token'];
      } else {
        throw Exception("Failed to validate request token with login");
      }

      //------------------------------Create session Id---------------------
      http.Response createSessionIdResponse = await http.post(
          Uri.parse(
            createSessionIdUrl,
          ),
          headers: headers,
          body: {
            "request_token": newRequestToken,
          });
      if (createSessionIdResponse.statusCode == 200) {
        log(createSessionIdResponse.body.toString());
        LoginSessionModel loginSessionModel =
            loginSessionModelFromJson(createSessionIdResponse.body.toString());
        return loginSessionModel;
      } else {
        throw Exception("Failed to generate session Id");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Failed to generate session Id with login");
  }
}
