import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? status;
  dynamic? data;
  String? message;
  String? userMsg;

  LoginModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: json['data'] != null
            ? json['data'].runtimeType == bool
                ? false
                : Data.fromJson(json['data'])
            : null,
        message: json["message"],
        userMsg: json["LoginModel_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
        "user_msg": userMsg,
      };
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.LoginModelname,
    this.profilePic,
    this.countryId,
    this.gender,
    this.phoneNo,
    this.dob,
    this.isActive,
    this.created,
    this.modified,
    this.accessToken,
  });

  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? LoginModelname;
  dynamic? profilePic;
  dynamic? countryId;
  String? gender;
  String? phoneNo;
  dynamic? dob;
  bool? isActive;
  String? created;
  String? modified;
  String? accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        roleId: json["role_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        LoginModelname: json["LoginModelname"],
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
        "LoginModelname": LoginModelname,
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
