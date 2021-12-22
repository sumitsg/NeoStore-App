import 'dart:convert';

ProfileEditedModel profileEditedModelFromJson(String str) =>
    ProfileEditedModel.fromJson(json.decode(str));

String profileEditedModelToJson(ProfileEditedModel data) =>
    json.encode(data.toJson());

class ProfileEditedModel {
  ProfileEditedModel({
    required this.status,
    required this.data,
    required this.message,
    required this.userMsg,
  });

  int status;
  Data data;
  String message;
  String userMsg;

  factory ProfileEditedModel.fromJson(Map<String, dynamic> json) =>
      ProfileEditedModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
        "user_msg": userMsg,
      };
}

class Data {
  Data({
    required this.id,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.profilePic,
    this.countryId,
    required this.gender,
    required this.phoneNo,
    required this.dob,
    required this.isActive,
    required this.created,
    required this.modified,
    required this.accessToken,
  });

  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String username;
  String profilePic;
  dynamic countryId;
  String gender;
  String phoneNo;
  String dob;
  bool isActive;
  String created;
  String modified;
  String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        roleId: json["role_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        username: json["username"],
        profilePic: json["profile_pic"],
        countryId: json["country_id"],
        gender: json["gender"],
        phoneNo: json["phone_no"],
        dob: json["dob"],
        isActive: json["is_active"],
        created: json["created"],
        modified: json["modified"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "username": username,
        "profile_pic": profilePic,
        "country_id": countryId,
        "gender": gender,
        "phone_no": phoneNo,
        "dob": dob,
        "is_active": isActive,
        "created": created,
        "modified": modified,
        "access_token": accessToken,
      };
}
