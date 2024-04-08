// To parse this JSON data, do
//
//     final tvShowDetailsModel = tvShowDetailsModelFromJson(jsonString);

import 'dart:convert';

TvShowDetailsModel tvShowDetailsModelFromJson(String str) =>
    TvShowDetailsModel.fromJson(json.decode(str));

String tvShowDetailsModelToJson(TvShowDetailsModel data) =>
    json.encode(data.toJson());

class TvShowDetailsModel {
  bool? adult;
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<dynamic>? episodeRunTime;
  DateTime? firstAirDate;
  List<Genre>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<OriginalLanguage>? languages;
  DateTime? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  dynamic nextEpisodeToAir;
  List<Network>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  OriginalLanguage? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Network>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  List<Season>? seasons;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;
  Credits? credits;
  Reviews? reviews;
  Similar? similar;
  Videos? videos;

  TvShowDetailsModel({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
    this.credits,
    this.reviews,
    this.similar,
    this.videos,
  });

  factory TvShowDetailsModel.fromJson(Map<String, dynamic> json) =>
      TvShowDetailsModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        createdBy: json["created_by"] == null
            ? []
            : List<CreatedBy>.from(
                json["created_by"]!.map((x) => CreatedBy.fromJson(x))),
        episodeRunTime: json["episode_run_time"] == null
            ? []
            : List<dynamic>.from(json["episode_run_time"]!.map((x) => x)),
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        homepage: json["homepage"] ?? "unavailable",
        id: json["id"] ?? 0,
        inProduction: json["in_production"] ?? false,
        languages: json["languages"] == null
            ? []
            : List<OriginalLanguage>.from(
                json["languages"]!.map((x) => originalLanguageValues.map[x]!)),
        lastAirDate: json["last_air_date"] == null
            ? null
            : DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: json["last_episode_to_air"] == null
            ? null
            : LastEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"] ?? "unavailable",
        nextEpisodeToAir: json["next_episode_to_air"] ?? "unavailable",
        networks: json["networks"] == null
            ? []
            : List<Network>.from(
                json["networks"]!.map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"] ?? 0,
        numberOfSeasons: json["number_of_seasons"] ?? 0,
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage:
            originalLanguageValues.map[json["original_language"]]!,
        originalName: json["original_name"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        productionCompanies: json["production_companies"] == null
            ? []
            : List<Network>.from(
                json["production_companies"]!.map((x) => Network.fromJson(x))),
        productionCountries: json["production_countries"] == null
            ? []
            : List<ProductionCountry>.from(json["production_countries"]!
                .map((x) => ProductionCountry.fromJson(x))),
        seasons: json["seasons"] == null
            ? []
            : List<Season>.from(
                json["seasons"]!.map((x) => Season.fromJson(x))),
        spokenLanguages: json["spoken_languages"] == null
            ? []
            : List<SpokenLanguage>.from(json["spoken_languages"]!
                .map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"] ?? "unavailable",
        tagline: json["tagline"] ?? "unavailable",
        type: json["type"] ?? "unavailable",
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        credits:
            json["credits"] == null ? null : Credits.fromJson(json["credits"]),
        reviews:
            json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
        similar:
            json["similar"] == null ? null : Similar.fromJson(json["similar"]),
        videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": createdBy == null
            ? []
            : List<dynamic>.from(createdBy!.map((x) => x.toJson())),
        "episode_run_time": episodeRunTime == null
            ? []
            : List<dynamic>.from(episodeRunTime!.map((x) => x)),
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": languages == null
            ? []
            : List<dynamic>.from(
                languages!.map((x) => originalLanguageValues.reverse[x])),
        "last_air_date":
            "${lastAirDate!.year.toString().padLeft(4, '0')}-${lastAirDate!.month.toString().padLeft(2, '0')}-${lastAirDate!.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir?.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "networks": networks == null
            ? []
            : List<dynamic>.from(networks!.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies == null
            ? []
            : List<dynamic>.from(productionCompanies!.map((x) => x.toJson())),
        "production_countries": productionCountries == null
            ? []
            : List<dynamic>.from(productionCountries!.map((x) => x.toJson())),
        "seasons": seasons == null
            ? []
            : List<dynamic>.from(seasons!.map((x) => x.toJson())),
        "spoken_languages": spokenLanguages == null
            ? []
            : List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "credits": credits?.toJson(),
        "reviews": reviews?.toJson(),
        "similar": similar?.toJson(),
        "videos": videos?.toJson(),
      };
}

class CreatedBy {
  int? id;
  String? creditId;
  String? name;
  int? gender;
  String? profilePath;

  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"] ?? 0,
        creditId: json["credit_id"] ?? "unavailable",
        name: json["name"] ?? "unavailable",
        gender: json["gender"] ?? 0,
        profilePath: json["profile_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };
}

class Credits {
  List<Cast>? cast;
  List<Cast>? crew;

  Credits({
    this.cast,
    this.crew,
  });

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
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
  int? gender;
  int? id;
  Department? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? character;
  String? creditId;
  int? order;
  Department? department;
  Job? job;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"] ?? false,
        gender: json["gender"] ?? 0,
        id: json["id"] ?? 0,
        knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        name: json["name"] ?? "unavailable",
        originalName: json["original_name"] ?? "unavailable",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        profilePath: json["profile_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        character: json["character"] ?? "unavailable",
        creditId: json["credit_id"] ?? "unavailable",
        order: json["order"] ?? 0,
        department: departmentValues.map[json["department"]] ?? Department.ACTING,
        job: jobValues.map[json["job"]] ?? Job.PRODUCER,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": departmentValues.reverse[department],
        "job": jobValues.reverse[job],
      };
}

enum Department { ACTING, DIRECTING, PRODUCTION, WRITING }

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Directing": Department.DIRECTING,
  "Production": Department.PRODUCTION,
  "Writing": Department.WRITING
});

enum Job { EXECUTIVE_PRODUCER, PRODUCER }

final jobValues = EnumValues(
    {"Executive Producer": Job.EXECUTIVE_PRODUCER, "Producer": Job.PRODUCER});

class Genre {
  int? id;
  String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? 0,
        name: json["name"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum OriginalLanguage { EN, TL }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "tl": OriginalLanguage.TL});

class LastEpisodeToAir {
  int? id;
  String? name;
  String? overview;
  double? voteAverage;
  int? voteCount;
  DateTime? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  LastEpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        id: json["id"] ?? 0,
        name: json["name"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        voteAverage: json["vote_average"] ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"] ?? 0,
        episodeType: json["episode_type"] ?? "unavailable",
        productionCode: json["production_code"] ?? "unavailable",
        runtime: json["runtime"] ?? 0,
        seasonNumber: json["season_number"] ?? 0,
        showId: json["show_id"] ?? 0,
        stillPath: json["still_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
      );
  //!Vote average ko data type int bata double ma change gareko ho

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
      };
}

class Network {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Network({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"] ?? 0,
        logoPath: json["logo_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        name: json["name"] ?? "unavailable",
        originCountry: json["origin_country"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  String? iso31661;
  String? name;

  ProductionCountry({
    this.iso31661,
    this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"] ?? "unavailable",
        name: json["name"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class Reviews {
  int? page;
  List<ReviewsResult>? results;
  int? totalPages;
  int? totalResults;

  Reviews({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        page: json["page"] ?? 0,
        results: json["results"] == null
            ? []
            : List<ReviewsResult>.from(
                json["results"]!.map((x) => ReviewsResult.fromJson(x))),
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

class ReviewsResult {
  String? author;
  AuthorDetails? authorDetails;
  String? content;
  DateTime? createdAt;
  String? id;
  DateTime? updatedAt;
  String? url;

  ReviewsResult({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory ReviewsResult.fromJson(Map<String, dynamic> json) => ReviewsResult(
        author: json["author"] ?? "unavailable",
        authorDetails: json["author_details"] == null
            ? null
            : AuthorDetails.fromJson(json["author_details"]),
        content: json["content"] ?? "unavailable",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] ?? "unavailable",
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        url: json["url"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "author_details": authorDetails?.toJson(),
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "url": url,
      };
}

class AuthorDetails {
  String? name;
  String? username;
  dynamic avatarPath;
  double? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"] ?? "unavailable",
        username: json["username"] ?? "unavailable",
        avatarPath: json["avatar_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        rating: json["rating"] ?? 0.0,
      );
  //!Rating ko datatype changed here, mathi declare garda nai change handeko ho

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
      };
}

class Season {
  DateTime? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        posterPath: json["poster_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        seasonNumber: json["season_number"] ?? 0,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}

class Similar {
  int? page;
  List<SimilarResult>? results;
  int? totalPages;
  int? totalResults;

  Similar({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        page: json["page"] ?? 0,
        results: json["results"] == null
            ? []
            : List<SimilarResult>.from(
                json["results"]!.map((x) => SimilarResult.fromJson(x))),
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

class SimilarResult {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  OriginalLanguage? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  SimilarResult({
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

  factory SimilarResult.fromJson(Map<String, dynamic> json) => SimilarResult(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"] ?? 0,
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage:
            originalLanguageValues.map[json["original_language"]]!,
        originalName: json["original_name"] ?? "unavailable",
        overview: json["overview"] ?? "unavailable",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        firstAirDate: json["first_air_date"] ?? "unavailable",
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
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class SpokenLanguage {
  String? englishName;
  OriginalLanguage? iso6391;
  String? name;

  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"] ?? "unavailable",
        iso6391: originalLanguageValues.map[json["iso_639_1"]]!,
        name: json["name"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": originalLanguageValues.reverse[iso6391],
        "name": name,
      };
}

class Videos {
  List<VideosResult>? results;

  Videos({
    this.results,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        results: json["results"] == null
            ? []
            : List<VideosResult>.from(
                json["results"]!.map((x) => VideosResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class VideosResult {
  OriginalLanguage? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  DateTime? publishedAt;
  String? id;

  VideosResult({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory VideosResult.fromJson(Map<String, dynamic> json) => VideosResult(
        iso6391: originalLanguageValues.map[json["iso_639_1"]]!,
        iso31661: json["iso_3166_1"] ?? "unavailable",
        name: json["name"] ?? "unavailable",
        key: json["key"] ?? "unavailable",
        site: json["site"] ?? "unavailable",
        size: json["size"] ?? 0,
        type: json["type"] ?? "unavailable",
        official: json["official"] ?? false,
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        id: json["id"] ?? "unavailable",
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": originalLanguageValues.reverse[iso6391],
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt?.toIso8601String(),
        "id": id,
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
