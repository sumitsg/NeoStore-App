import 'dart:convert';

ProfileDetailsModel ProfileDetailsModelFromJson(String str) =>
    ProfileDetailsModel.fromJson(json.decode(str));

String ProfileDetailsModelToJson(ProfileDetailsModel data) =>
    json.encode(data.toJson());

class ProfileDetailsModel {
  ProfileDetailsModel({
    required this.status,
    required this.data,
  });

  int status;
  Data data;

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userData,
    required this.productCategories,
    required this.totalCarts,
    required this.totalOrders,
  });

  UserData userData;
  List<ProductCategory> productCategories;
  int totalCarts;
  int totalOrders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["user_data"]),
        productCategories: List<ProductCategory>.from(
            json["product_categories"].map((x) => ProductCategory.fromJson(x))),
        totalCarts: json["total_carts"],
        totalOrders: json["total_orders"],
      );

  Map<String, dynamic> toJson() => {
        "user_data": userData.toJson(),
        "product_categories":
            List<dynamic>.from(productCategories.map((x) => x.toJson())),
        "total_carts": totalCarts,
        "total_orders": totalOrders,
      };
}

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.name,
    required this.iconImage,
    required this.created,
    required this.modified,
  });

  int id;
  String name;
  String iconImage;
  String created;
  String modified;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        iconImage: json["icon_image"],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_image": iconImage,
        "created": created,
        "modified": modified,
      };
}

class UserData {
  UserData({
    required this.id,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.profilePic,
    this.countryId,
    required this.gender,
    required this.phoneNo,
    this.dob,
    required this.isActive,
    required this.created,
    required this.modified,
    required this.accessToken,
  });

  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String username;
  dynamic profilePic;
  dynamic countryId;
  String gender;
  String phoneNo;
  dynamic dob;
  bool isActive;
  String created;
  String modified;
  String accessToken;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        roleId: json["role_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        username: json["username"],
        profilePic: json["profile_pic"],
        countryId: json["country_id"],
        gender: json["gender"],
        phoneNo: json["phone_no"],
        dob: json["dob"],
        isActive: json["is_active"],
        created: json["created"],
        modified: json["modified"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "username": username,
        "profile_pic": profilePic,
        "country_id": countryId,
        "gender": gender,
        "phone_no": phoneNo,
        "dob": dob,
        "is_active": isActive,
        "created": created,
        "modified": modified,
        "access_token": accessToken,
      };
}
