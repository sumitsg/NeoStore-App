import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    required this.status,
    required this.data,
  });

  int status;
  Data2? data;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        status: json["status"],
        data: Data2.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data2 {
  Data2({
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
  List<ProductImage> productImages;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
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
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
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
        "product_images":
            List<dynamic>.from(productImages.map((x) => x.toJson())),
      };
}

class ProductImage {
  ProductImage({
    required this.id,
    required this.productId,
    required this.image,
    required this.created,
    required this.modified,
  });

  int id;
  int productId;
  String image;
  String created;
  String modified;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        productId: json["product_id"],
        image: json["image"],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image": image,
        "created": created,
        "modified": modified,
      };
}
