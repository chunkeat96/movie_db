class CastDetailsModel {
  final bool? adult;
  final List<String>? alsoKnownAs;
  final String? biography;
  final DateTime? birthday;
  final int? gender;
  final int? id;
  final String? imdbId;
  final String? knownForDepartment;
  final String? name;
  final String? placeOfBirth;
  final num? popularity;
  final String? profilePath;

  CastDetailsModel({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.gender,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  factory CastDetailsModel.fromJson(Map<String, dynamic> json) => CastDetailsModel(
    adult: json["adult"],
    alsoKnownAs: json["also_known_as"] == null ? [] : List<String>.from(json["also_known_as"]!.map((x) => x)),
    biography: json["biography"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    gender: json["gender"],
    id: json["id"],
    imdbId: json["imdb_id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    placeOfBirth: json["place_of_birth"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "also_known_as": alsoKnownAs == null ? [] : List<dynamic>.from(alsoKnownAs!.map((x) => x)),
    "biography": biography,
    "birthday": "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "id": id,
    "imdb_id": imdbId,
    "known_for_department": knownForDepartment,
    "name": name,
    "place_of_birth": placeOfBirth,
    "popularity": popularity,
    "profile_path": profilePath,
  };
}
