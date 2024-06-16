import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:netflix/models/For%20APIs/auth/delete_session_model.dart';

import '../../config/app_constants.dart';

class DeleteSessionRepo {
  //----------------------------------Deleting Session-------------------------------------
  Future<DeleteSessionModel> deleteSession(
    String sessionId,
  ) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };

    try {
      http.Response response = await http.delete(
        Uri.parse(
          "https://api.themoviedb.org/3/authentication/session",
        ),
        headers: headers,
        body: {
          "session_id": sessionId,
        },
      );
      if (response.statusCode == 200) {
        DeleteSessionModel deleteSessionModel =
            deleteSessionModelFromJson(response.body.toString());
        return deleteSessionModel;
      } else {
        throw Exception("Failed to delete session");
      }
    } catch (e) {
      log("Exception caught: $e");
    }
    throw Exception("Please relaunch the app :   Failed to delete session");
  }
}
