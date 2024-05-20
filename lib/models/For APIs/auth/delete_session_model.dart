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

  LoginSessionModel({
    this.success,
  });

  factory LoginSessionModel.fromJson(Map<String, dynamic> json) =>
      LoginSessionModel(
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
