// To parse this JSON data, do
//
//     final editCartModel = editCartModelFromJson(jsonString);

import 'dart:convert';

EditCartModel editCartModelFromJson(String str) =>
    EditCartModel.fromJson(json.decode(str));

String editCartModelToJson(EditCartModel data) => json.encode(data.toJson());

class EditCartModel {
  EditCartModel({
    required this.status,
    required this.data,
    required this.totalCarts,
    required this.message,
    required this.userMsg,
  });

  int status;
  bool data;
  int totalCarts;
  String message;
  String userMsg;

  factory EditCartModel.fromJson(Map<String, dynamic> json) => EditCartModel(
        status: json["status"],
        data: json["data"],
        totalCarts: json["total_carts"],
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "total_carts": totalCarts,
        "message": message,
        "user_msg": userMsg,
      };
}
