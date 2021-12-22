// To parse this JSON data, do
//
//     final myOrderDetailModel = myOrderDetailModelFromJson(jsonString);

import 'dart:convert';

MyOrderDetailModel myOrderDetailModelFromJson(String str) =>
    MyOrderDetailModel.fromJson(json.decode(str));

String myOrderDetailModelToJson(MyOrderDetailModel data) =>
    json.encode(data.toJson());

class MyOrderDetailModel {
  MyOrderDetailModel({
    required this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  int status;
  Data? data;
  String? message;
  String? userMsg;

  factory MyOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      MyOrderDetailModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        // data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        // data: json['data'] != null
        //     ? List<Data>.from(json['data']!.map((x) => Data.fromJson(x)))
        //         .toList()
        //     : null,
        message: json['message'],
        userMsg: json['user_msg'],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "data": data,
        "message": message,
        "user_msg": userMsg,
      };
}

class Data {
  Data({
    required this.id,
    required this.cost,
    required this.address,
    required this.orderDetails,
  });

  int id;
  int cost;
  String address;
  List<OrderDetail>? orderDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        cost: json["cost"],
        address: json["address"],
        orderDetails: List<OrderDetail>.from(
            json["order_details"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cost": cost,
        "address": address,
        "order_details":
            List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.total,
    required this.prodName,
    required this.prodCatName,
    required this.prodImage,
  });

  int id;
  int orderId;
  int productId;
  int quantity;
  int total;
  String prodName;
  String prodCatName;
  String prodImage;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        total: json["total"],
        prodName: json["prod_name"],
        prodCatName: json["prod_cat_name"],
        prodImage: json["prod_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "total": total,
        "prod_name": prodName,
        "prod_cat_name": prodCatName,
        "prod_image": prodImage,
      };
}
