// To parse this JSON data, do
//
//     final peopleDetailsModel = peopleDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:netflix/config/app_constants.dart';

PeopleDetailsModel peopleDetailsModelFromJson(String str) =>
    PeopleDetailsModel.fromJson(json.decode(str));

String peopleDetailsModelToJson(PeopleDetailsModel data) =>
    json.encode(data.toJson());

class PeopleDetailsModel {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  DateTime? birthday;
  dynamic deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;
  CombinedCredits? combinedCredits;
  ExternalIds? externalIds;
  Images? images;

  PeopleDetailsModel({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
    this.combinedCredits,
    this.externalIds,
    this.images,
  });

  factory PeopleDetailsModel.fromJson(Map<String, dynamic> json) =>
      PeopleDetailsModel(
        adult: json["adult"] ?? false,
        alsoKnownAs: json["also_known_as"] == null
            ? []
            : List<String>.from(json["also_known_as"]!.map((x) => x)),
        biography: json["biography"] ?? "unavailable",
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        deathday:
            json["deathday"] == null ? null : DateTime.parse(json["deathday"]),
        gender: json["gender"] ?? 0,
        homepage: json["homepage"] ?? "unavailable",
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"] ?? "unavailable",
        knownForDepartment: json["known_for_department"] ?? "unavailable",
        name: json["name"] ?? "unavailable",
        placeOfBirth: json["place_of_birth"] ?? "unavailable",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        profilePath: json["profile_path"] ?? AppConstants.placeHolderImage,
        combinedCredits: json["combined_credits"] == null
            ? null
            : CombinedCredits.fromJson(json["combined_credits"]),
        externalIds: json["external_ids"] == null
            ? null
            : ExternalIds.fromJson(json["external_ids"]),
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "also_known_as": alsoKnownAs == null
            ? []
            : List<dynamic>.from(alsoKnownAs!.map((x) => x)),
        "biography": biography,
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "deathday": deathday,
        "gender": gender,
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "known_for_department": knownForDepartment,
        "name": name,
        "place_of_birth": placeOfBirth,
        "popularity": popularity,
        "profile_path": profilePath,
        "combined_credits": combinedCredits?.toJson(),
        "external_ids": externalIds?.toJson(),
        "images": images?.toJson(),
      };
}

class CombinedCredits {
  List<Cast>? cast;
  List<Cast>? crew;

  CombinedCredits({
    this.cast,
    this.crew,
  });

  factory CombinedCredits.fromJson(Map<String, dynamic> json) =>
      CombinedCredits(
        cast: json["cast"] == null
            ? []
            : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
        crew: json["crew"] == null
            ? []
            : List<Cast>.from(json["crew"]!.map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cast": cast == null
            ? []
            : List<dynamic>.from(cast!.map((x) => x.toJson())),
        "crew": crew == null
            ? []
            : List<dynamic>.from(crew!.map((x) => x.toJson())),
      };
}

class Cast {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? character;
  String? creditId;
  int? order;
  MediaType? mediaType;
  List<String>? originCountry;
  String? originalName;
  DateTime? firstAirDate;
  String? name;
  int? episodeCount;
  Department? department;
  Job? job;

  Cast({
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
    this.character,
    this.creditId,
    this.order,
    this.mediaType,
    this.originCountry,
    this.originalName,
    this.firstAirDate,
    this.name,
    this.episodeCount,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? AppConstants.placeHolderImage,
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"] ?? 0,
        originalLanguage:
            originalLanguageValues.map[json["original_language"]] ??
                OriginalLanguage.EN,
        originalTitle: json["original_title"] ?? "Unavailable",
        overview: json["overview"] ?? "Unavailable",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? AppConstants.placeHolderImage,
        releaseDate: json["release_date"] ?? "Unavailable", 
        title: json["title"] ?? "Unavailable",
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        character: json["character"] ?? "Unavailable",
        creditId: json["credit_id"] ?? "Unavailable",
        order: json["order"] ?? 0,
        mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.MOVIE,
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalName: json["original_name"] ?? "Unavailable",
        firstAirDate: json["first_air_date"] == null ? null : DateTime.now(),
        name: json["name"] ?? "Unavailable",
        episodeCount: json["episode_count"] ?? 0,
        department: departmentValues.map[json["department"]] ?? Department.CREW,
        job: jobValues.map[json["job"]] ?? Job.DIRECTOR,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "media_type": mediaTypeValues.reverse[mediaType],
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_name": originalName,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "episode_count": episodeCount,
        "department": departmentValues.reverse[department],
        "job": jobValues.reverse[job],
      };
}

enum Department { CREW, DIRECTING, PRODUCTION, WRITING }

final departmentValues = EnumValues(
  {
    "Crew": Department.CREW,
    "Directing": Department.DIRECTING,
    "Production": Department.PRODUCTION,
    "Writing": Department.WRITING
  },
);

enum Job { DIRECTOR, EXECUTIVE_PRODUCER, PRODUCER, THANKS, WRITER }

final jobValues = EnumValues(
  {
    "Director": Job.DIRECTOR,
    "Executive Producer": Job.EXECUTIVE_PRODUCER,
    "Producer": Job.PRODUCER,
    "Thanks": Job.THANKS,
    "Writer": Job.WRITER
  },
);

enum MediaType { MOVIE, TV }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

enum OriginalLanguage { DE, EN, FR, HU, KO }

final originalLanguageValues = EnumValues(
  {
    "de": OriginalLanguage.DE,
    "en": OriginalLanguage.EN,
    "fr": OriginalLanguage.FR,
    "hu": OriginalLanguage.HU,
    "ko": OriginalLanguage.KO
  },
);

class ExternalIds {
  String? freebaseMid;
  String? freebaseId;
  String? imdbId;
  int? tvrageId;
  String? wikidataId;
  String? facebookId;
  String? instagramId;
  dynamic tiktokId;
  String? twitterId;
  dynamic youtubeId;

  ExternalIds({
    this.freebaseMid,
    this.freebaseId,
    this.imdbId,
    this.tvrageId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.tiktokId,
    this.twitterId,
    this.youtubeId,
  });

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        freebaseMid: json["freebase_mid"] ?? "unavailable",
        freebaseId: json["freebase_id"] ?? "unavailable",
        imdbId: json["imdb_id"] ?? "unavailable",
        tvrageId: json["tvrage_id"] ?? 0,
        wikidataId: json["wikidata_id"] ?? "unavailable",
        facebookId: json["facebook_id"] ?? "unavailable",
        instagramId: json["instagram_id"] ?? "unavailable",
        tiktokId: json["tiktok_id"] ?? "unavailable",
        twitterId: json["twitter_id"] ?? "unavailable",
        youtubeId: json["youtube_id"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "freebase_mid": freebaseMid,
        "freebase_id": freebaseId,
        "imdb_id": imdbId,
        "tvrage_id": tvrageId,
        "wikidata_id": wikidataId,
        "facebook_id": facebookId,
        "instagram_id": instagramId,
        "tiktok_id": tiktokId,
        "twitter_id": twitterId,
        "youtube_id": youtubeId,
      };
}

class Images {
  List<Profile>? profiles;

  Images({
    this.profiles,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        profiles: json["profiles"] == null
            ? []
            : List<Profile>.from(
                json["profiles"]!.map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profiles": profiles == null
            ? []
            : List<dynamic>.from(profiles!.map((x) => x.toJson())),
      };
}

class Profile {
  double? aspectRatio;
  int? height;
  dynamic iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Profile({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        aspectRatio: json["aspect_ratio"]?.toDouble() ?? 0.0,
        height: json["height"] ?? 0,
        iso6391: json["iso_639_1"] ?? "unavailable",
        filePath: json["file_path"] ?? AppConstants.placeHolderImage,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        width: json["width"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "height": height,
        "iso_639_1": iso6391,
        "file_path": filePath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
