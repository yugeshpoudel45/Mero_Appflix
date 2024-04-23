// To parse this JSON data, do
//
//     final trendingPeopleModel = trendingPeopleModelFromJson(jsonString);

import 'dart:convert';

import 'package:netflix/config/app_constants.dart';

TrendingPeopleModel trendingPeopleModelFromJson(String str) =>
    TrendingPeopleModel.fromJson(json.decode(str));

String trendingPeopleModelToJson(TrendingPeopleModel data) =>
    json.encode(data.toJson());

class TrendingPeopleModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  TrendingPeopleModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TrendingPeopleModel.fromJson(Map<String, dynamic> json) =>
      TrendingPeopleModel(
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
  int? id;
  String? name;
  String? originalName;
  ResultMediaType? mediaType;
  double? popularity;
  int? gender;
  KnownForDepartment? knownForDepartment;
  String? profilePath;
  List<KnownFor>? knownFor;

  Result({
    this.adult,
    this.id,
    this.name,
    this.originalName,
    this.mediaType,
    this.popularity,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.knownFor,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        id: json["id"] ?? 0,
        name: json["name"] ?? "unavailable",
        originalName: json["original_name"] ?? "unavailable",
        mediaType: resultMediaTypeValues.map[json["media_type"]] ??
            ResultMediaType.PERSON,
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        gender: json["gender"] ?? 0,
        knownForDepartment:
            knownForDepartmentValues.map[json["known_for_department"]] ??
                KnownForDepartment.ACTING,
        profilePath: json["profile_path"] ?? AppConstants.placeHolderImage,
        knownFor: json["known_for"] == null
            ? []
            : List<KnownFor>.from(
                json["known_for"]!.map((x) => KnownFor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "id": id,
        "name": name,
        "original_name": originalName,
        "media_type": resultMediaTypeValues.reverse[mediaType],
        "popularity": popularity,
        "gender": gender,
        "known_for_department":
            knownForDepartmentValues.reverse[knownForDepartment],
        "profile_path": profilePath,
        "known_for": knownFor == null
            ? []
            : List<dynamic>.from(knownFor!.map((x) => x.toJson())),
      };
}

class KnownFor {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  KnownForMediaType? mediaType;
  List<int>? genreIds;
  double? popularity;
  DateTime? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<String>? originCountry;

  KnownFor({
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
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? AppConstants.placeHolderImage,
        id: json["id"] ?? 0,
        title: json["title"] ?? "unavailable",
        originalLanguage:
            originalLanguageValues.map[json["original_language"]] ??
                OriginalLanguage.EN,
        originalTitle: json["original_title"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        posterPath: json["poster_path"] ?? AppConstants.placeHolderImage,
        mediaType: knownForMediaTypeValues.map[json["media_type"]] ??
            KnownForMediaType.MOVIE,
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        releaseDate: json["release_date"] == null ? null : DateTime.now(),
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        name: json["name"] ?? "unavailable",
        originalName: json["original_name"] ?? "unavailable",
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
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
        "media_type": knownForMediaTypeValues.reverse[mediaType],
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "release_date": releaseDate != null
            ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
            : null,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "first_air_date": firstAirDate != null
            ? "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}"
            : null,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
      };
}

enum KnownForMediaType { MOVIE, TV }

final knownForMediaTypeValues =
    EnumValues({"movie": KnownForMediaType.MOVIE, "tv": KnownForMediaType.TV});

enum OriginalLanguage { EN, KO, TH, TL }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ko": OriginalLanguage.KO,
  "th": OriginalLanguage.TH,
  "tl": OriginalLanguage.TL
});

enum KnownForDepartment { ACTING, CREW, DIRECTING }

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING,
  "Crew": KnownForDepartment.CREW,
  "Directing": KnownForDepartment.DIRECTING
});

enum ResultMediaType { PERSON }

final resultMediaTypeValues = EnumValues({"person": ResultMediaType.PERSON});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
