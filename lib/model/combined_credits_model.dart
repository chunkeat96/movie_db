class CombinedCreditsModel {
  final List<Cast>? cast;

  CombinedCreditsModel({
    this.cast,
  });

  factory CombinedCreditsModel.fromJson(Map<String, dynamic> json) => CombinedCreditsModel(
    cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toJson())),
  };
}

class Cast {
  final bool? adult;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final String? title;
  final bool? video;
  final num? voteAverage;
  final num? voteCount;
  final String? character;
  final String? creditId;
  final int? order;
  final String? mediaType;

  Cast({
    this.adult,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.character,
    this.creditId,
    this.order,
    this.mediaType,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    mediaType: json["media_type"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "media_type": mediaType,
  };

  num get formatPopularity => popularity ?? 0;
}
