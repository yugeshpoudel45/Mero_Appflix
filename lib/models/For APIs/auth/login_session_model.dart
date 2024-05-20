// To parse this JSON data, do
//
//     final loginSessionModel = loginSessionModelFromJson(jsonString);

import 'dart:convert';

LoginSessionModel loginSessionModelFromJson(String str) =>
    LoginSessionModel.fromJson(json.decode(str));

String loginSessionModelToJson(LoginSessionModel data) =>
    json.encode(data.toJson());

class LoginSessionModel {
  bool? success;
  String? sessionId;

  LoginSessionModel({
    this.success,
    this.sessionId,
  });

  factory LoginSessionModel.fromJson(Map<String, dynamic> json) =>
      LoginSessionModel(
        success: json["success"] ?? false,
        sessionId: json["session_id"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "session_id": sessionId,
      };
}
