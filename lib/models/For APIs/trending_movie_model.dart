// To parse this JSON data, do
//
//     final trendingMovieModel = trendingMovieModelFromJson(jsonString);

import 'dart:convert';

TrendingMovieModel trendingMovieModelFromJson(String str) =>
    TrendingMovieModel.fromJson(json.decode(str));

String trendingMovieModelToJson(TrendingMovieModel data) =>
    json.encode(data.toJson());

class TrendingMovieModel {
  int? page;
  List<Result>? results;

  TrendingMovieModel({
    this.page,
    this.results,
  });

  factory TrendingMovieModel.fromJson(Map<String, dynamic> json) =>
      TrendingMovieModel(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  MediaType? mediaType;
  List<int>? genreIds;
  double? popularity;
  DateTime? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? martialLawHasBeenDeclaredACoupD;

  Result({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.martialLawHasBeenDeclaredACoupD,
  });


  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "Not available",
        id: json["id"] ?? 45,
        title: json["title"] ?? "Not available",
        originalLanguage:
            originalLanguageValues.map[json["original_language"]] ??
                OriginalLanguage.en,
        originalTitle: json["original_title"] ?? "Not available",
        overview: json["overview"] ?? "Not available",
        posterPath: json["poster_path"] ?? "Not available",
        mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.movie,
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble() ?? 45.0,
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 45.0,
        voteCount: json["vote_count"] ?? 45,
        martialLawHasBeenDeclaredACoupD:
            json["martial law has been declared. A coup d"] ?? "Not available",
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "martial law has been declared. A coup d":
            martialLawHasBeenDeclaredACoupD,
      };
}

enum MediaType { movie }

final mediaTypeValues = EnumValues({"movie": MediaType.movie});

enum OriginalLanguage { en, ko }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.en, "ko": OriginalLanguage.ko});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
