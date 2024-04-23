// To parse this JSON data, do
//
//     final tvShowSearchModel = tvShowSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:netflix/config/app_constants.dart';

TvShowSearchModel tvShowSearchModelFromJson(String str) =>
    TvShowSearchModel.fromJson(json.decode(str));

String tvShowSearchModelToJson(TvShowSearchModel data) =>
    json.encode(data.toJson());

class TvShowSearchModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  TvShowSearchModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TvShowSearchModel.fromJson(Map<String, dynamic> json) =>
      TvShowSearchModel(
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
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? AppConstants.placeHolderImage,
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"] ?? 0,
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"] ?? "en",
        originalName: json["original_name"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? AppConstants.placeHolderImage,
        firstAirDate: json["first_air_date"] == null ? null : DateTime.now(),
        name: json["name"] ?? "unavailable",
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
