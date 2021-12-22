// To parse this JSON data, do
//
//     final forgotPassModel = forgotPassModelFromJson(jsonString);

import 'dart:convert';

ForgotPassModel forgotPassModelFromJson(String str) =>
    ForgotPassModel.fromJson(json.decode(str));

String forgotPassModelToJson(ForgotPassModel data) =>
    json.encode(data.toJson());

class ForgotPassModel {
  ForgotPassModel({
    required this.status,
    required this.message,
    required this.userMsg,
  });

  int status;
  String message;
  String userMsg;

  factory ForgotPassModel.fromJson(Map<String, dynamic> json) =>
      ForgotPassModel(
        status: json["status"],
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_msg": userMsg,
      };
}
