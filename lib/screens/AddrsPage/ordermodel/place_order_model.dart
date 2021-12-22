// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) =>
    json.encode(data.toJson());

class PlaceOrderModel {
  PlaceOrderModel({
    required this.status,
    required this.message,
    required this.userMsg,
  });

  int status;
  String message;
  String userMsg;

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
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
