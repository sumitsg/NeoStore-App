import 'dart:convert';

ProductRatingModel productRatingModelFromJson(String str) =>
    ProductRatingModel.fromJson(json.decode(str));

String productRatingModelToJson(ProductRatingModel data) =>
    json.encode(data.toJson());

class ProductRatingModel {
  ProductRatingModel({
    required this.status,
    required this.data,
    required this.message,
    required this.userMsg,
  });

  int status;
  Data data;
  String message;
  String userMsg;

  factory ProductRatingModel.fromJson(Map<String, dynamic> json) =>
      ProductRatingModel(
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
    required this.productCategoryId,
    required this.name,
    required this.producer,
    required this.description,
    required this.cost,
    required this.rating,
    required this.viewCount,
    required this.created,
    required this.modified,
  });

  int id;
  int productCategoryId;
  String name;
  String producer;
  String description;
  int cost;
  double rating;
  int viewCount;
  String created;
  String modified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        producer: json["producer"],
        description: json["description"],
        cost: json["cost"],
        rating: json["rating"].toDouble(),
        viewCount: json["view_count"],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_category_id": productCategoryId,
        "name": name,
        "producer": producer,
        "description": description,
        "cost": cost,
        "rating": rating,
        "view_count": viewCount,
        "created": created,
        "modified": modified,
      };
}
