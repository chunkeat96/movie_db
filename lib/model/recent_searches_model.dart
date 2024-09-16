class RecentSearchesModel {
  int? id;
  String? poster;
  String? title;
  String? overview;

  RecentSearchesModel({this.id, this.poster, this.title, this.overview});

  RecentSearchesModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    poster = json['poster'];
    title = json['title'];
    overview = json['overview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['poster'] = poster;
    data['title'] = title;
    data['overview'] = overview;
    return data;
  }
}
