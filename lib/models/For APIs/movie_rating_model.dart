// To parse this JSON data, do
//
//     final movieRatingModel = movieRatingModelFromJson(jsonString);

import 'dart:convert';

MovieRatingModel movieRatingModelFromJson(String str) =>
    MovieRatingModel.fromJson(json.decode(str));

String movieRatingModelToJson(MovieRatingModel data) =>
    json.encode(data.toJson());

class MovieRatingModel {
  bool? success;
  int? statusCode;
  String? statusMessage;

  MovieRatingModel({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  factory MovieRatingModel.fromJson(Map<String, dynamic> json) =>
      MovieRatingModel(
        success: json["success"] ?? false,
        statusCode: json["status_code"] ?? 0,
        statusMessage: json["status_message"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "status_message": statusMessage,
      };
}
