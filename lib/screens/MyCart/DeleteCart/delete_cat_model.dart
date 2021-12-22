// To parse this JSON data, do
//
//     final deleteCartModel = deleteCartModelFromJson(jsonString);

import 'dart:convert';

DeleteCartModel deleteCartModelFromJson(String str) =>
    DeleteCartModel.fromJson(json.decode(str));

String deleteCartModelToJson(DeleteCartModel data) =>
    json.encode(data.toJson());

class DeleteCartModel {
  DeleteCartModel({
    required this.status,
    required this.data,
    required this.totalCarts,
    required this.message,
    required this.userMsg,
  });

  int status;
  bool? data;
  int totalCarts;
  String message;
  String userMsg;

  factory DeleteCartModel.fromJson(Map<String, dynamic> json) =>
      DeleteCartModel(
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
