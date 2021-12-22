import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  ProductListModel({
    required this.status,
    required this.data,
  });

  int status;
  List<Data> data;

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        status: json["status"],
        data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
    required this.productImages,
  });

  int id;
  int productCategoryId;
  String name;
  String producer;
  String description;
  int cost;
  int rating;
  int viewCount;
  String created;
  String modified;
  String productImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        producer: json["producer"],
        description: json["description"],
        cost: json["cost"],
        rating: json["rating"],
        viewCount: json["view_count"],
        created: json["created"],
        modified: json["modified"],
        productImages: json["product_images"],
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
        "product_images": productImages,
      };
}
