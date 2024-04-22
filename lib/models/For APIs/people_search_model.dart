// To parse this JSON data, do
//
//     final peopleSearchModel = peopleSearchModelFromJson(jsonString);

import 'dart:convert';

PeopleSearchModel peopleSearchModelFromJson(String str) =>
    PeopleSearchModel.fromJson(json.decode(str));

String peopleSearchModelToJson(PeopleSearchModel data) =>
    json.encode(data.toJson());

class PeopleSearchModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  PeopleSearchModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PeopleSearchModel.fromJson(Map<String, dynamic> json) =>
      PeopleSearchModel(
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
  int? gender;
  int? id;
  KnownForDepartment? knownForDepartment;
  Name? name;
  Name? originalName;
  double? popularity;
  String? profilePath;
  List<KnownFor>? knownFor;

  Result({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.knownFor,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        gender: json["gender"] ?? 0,
        id: json["id"] ?? 0,
        knownForDepartment:
            knownForDepartmentValues.map[json["known_for_department"]] ??
                KnownForDepartment.ACTING,
        name: nameValues.map[json["name"]] ?? Name.unavailable,
        originalName: nameValues.map[json["original_name"]] ?? Name.unavailable,
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        profilePath: json["profile_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        knownFor: json["known_for"] == null
            ? []
            : List<KnownFor>.from(
                json["known_for"]!.map((x) => KnownFor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department":
            knownForDepartmentValues.reverse[knownForDepartment],
        "name": nameValues.reverse[name],
        "original_name": nameValues.reverse[originalName],
        "popularity": popularity,
        "profile_path": profilePath,
        "known_for": knownFor == null
            ? []
            : List<dynamic>.from(knownFor!.map((x) => x.toJson())),
      };
}

class KnownFor {
  String? backdropPath;
  int? id;
  String? originalName;
  String? overview;
  String? posterPath;
  MediaType? mediaType;
  bool? adult;
  String? name;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  DateTime? firstAirDate;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;
  String? originalTitle;
  String? title;
  String? releaseDate;
  bool? video;

  KnownFor({
    this.backdropPath,
    this.id,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.name,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
    this.originalTitle,
    this.title,
    this.releaseDate,
    this.video,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        backdropPath:
            json["backdrop_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        id: json["id"] ?? 0,
        originalName: json["original_name"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        posterPath: json["poster_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.MOVIE,
        adult: json["adult"] ?? false,
        name: json["name"] ?? "unavailable",
        originalLanguage: json["original_language"] ?? "unavailable",
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalTitle: json["original_title"] ?? "unavailable",
        title: json["title"] ?? "unavailable",
        releaseDate: json["release_date"] ?? "unavailable",
        video: json["video"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "adult": adult,
        "name": name,
        "original_language": originalLanguage,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_title": originalTitle,
        "title": title,
        "release_date": releaseDate,
        "video": video,
      };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

enum KnownForDepartment { ACTING, ART, CREW, DIRECTING }

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING,
  "Art": KnownForDepartment.ART,
  "Crew": KnownForDepartment.CREW,
  "Directing": KnownForDepartment.DIRECTING
});

enum Name { unavailable }

final nameValues = EnumValues({"unavailable": Name.unavailable});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
