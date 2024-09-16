class UserModel {
  Profile? profile;

  UserModel({
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile?.toJson(),
  };
}

class Profile {
  String? memberCode;
  String? token;

  Profile({
    this.memberCode,
    this.token,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    memberCode: json["memberCode"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "memberCode": memberCode,
    "token": token,
  };
}
