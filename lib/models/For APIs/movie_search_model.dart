// To parse this JSON data, do
//
//     final movieSearchModel = movieSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:netflix/config/app_constants.dart';

MovieSearchModel movieSearchModelFromJson(String str) =>
    MovieSearchModel.fromJson(json.decode(str));

String movieSearchModelToJson(MovieSearchModel data) =>
    json.encode(data.toJson());

class MovieSearchModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  MovieSearchModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) =>
      MovieSearchModel(
        page: json["page"] ?? 0,
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? AppConstants.placeHolderImage,
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"] ?? "en",
        originalTitle: json["original_title"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? AppConstants.placeHolderImage,
        releaseDate: json["release_date"] ?? "unavailable",
        title: json["title"] ?? "unavailable",
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
