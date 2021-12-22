// To parse this JSON data, do
//
//     final myOrdersListModel = myOrdersListModelFromJson(jsonString);

import 'dart:convert';

MyOrdersListModel myOrdersListModelFromJson(String str) =>
    MyOrdersListModel.fromJson(json.decode(str));

String myOrdersListModelToJson(MyOrdersListModel data) =>
    json.encode(data.toJson());

class MyOrdersListModel {
  MyOrdersListModel({
    required this.status,
    required this.data,
    required this.message,
    required this.userMsg,
  });

  int status;
  List<Data>? data;
  String? message;
  String? userMsg;

  factory MyOrdersListModel.fromJson(Map<String, dynamic> json) =>
      MyOrdersListModel(
        status: json["status"],
        // data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        data: json['data'] != null
            ? List<Data>.from(json["data"].map((x) => Data.fromJson(x)))
            : null,
        message: json["message"] ?? null,
        userMsg: json["user_msg"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "user_msg": userMsg,
      };
}

class Data {
  Data({
    required this.id,
    required this.cost,
    required this.created,
  });

  int id;
  int cost;
  String created;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        cost: json["cost"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cost": cost,
        "created": created,
      };
}
