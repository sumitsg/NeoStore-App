// To parse this JSON data, do
//
//     final ItemsInCartModel = ItemsInCartModelFromJson(jsonString);

import 'dart:convert';

ItemsInCartModel itemsInCartModelFromJson(String str) =>
    ItemsInCartModel.fromJson(json.decode(str));

String itemsInCartModelToJson(ItemsInCartModel data) =>
    json.encode(data.toJson());

class ItemsInCartModel {
  ItemsInCartModel({
    required this.status,
    required this.data,
    required this.count,
    required this.total,
  });

  int status;
  List<Datum>? data;
  int count;
  int total;

  factory ItemsInCartModel.fromJson(Map<String, dynamic> json) =>
      ItemsInCartModel(
        status: json["status"],
        // data: List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        data: json['data'] != null
            ? List<Datum>.from(json['data']!.map((x) => Datum.fromJson(x)))
                .toList()
            : null,
        count: json["count"] ?? 0,
        total: json["total"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  int id;
  int productId;
  int quantity;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "product": product.toJson(),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.cost,
    required this.productCategory,
    required this.productImages,
    required this.subTotal,
  });

  int id;
  String name;
  int cost;
  String productCategory;
  String productImages;
  int subTotal;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        cost: json["cost"],
        productCategory: json["product_category"],
        productImages: json["product_images"],
        subTotal: json["sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
        "product_category": productCategory,
        "product_images": productImages,
        "sub_total": subTotal,
      };
}
