import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/screens/MyCart/DeleteCart/delete_cat_model.dart';
import 'package:neosoft_training_app/screens/MyCart/EditCart/edit_cart_model.dart';
import 'package:neosoft_training_app/screens/MyCart/item_in_cart_model.dart';
import 'package:neosoft_training_app/screens/my_order/my_orders_model.dart';
import 'package:neosoft_training_app/screens/my_order/orderDetails/orderdetail_model.dart';
import 'package:neosoft_training_app/screens/products/ProductRating/rating_model.dart';
import 'package:neosoft_training_app/screens/products/productDetails/add_to_cart_model.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_model.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/profile/profile_edited_model.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_password_model.dart';
import 'package:neosoft_training_app/screens/signUp/login/login_model.dart';
import 'package:neosoft_training_app/screens/signUp/register/register_model.dart';
import 'package:neosoft_training_app/shared_pref/user_shared_pref.dart';

class AuthRepository {
// !______________________ONBOARDING APIS_________________________________

  // ! Login------>
  Future<LoginModel?> createModel(String? email, String? password) async {
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/users/login';
    final responce = await http.post(Uri.parse(url), body: {
      "email": email,
      "password": password,
    });
    final resBody = jsonDecode(responce.body);
    if (responce.statusCode == 200) {
      final result = loginModelFromJson(responce.body);
      await UserPreference.setProfilePicture(result);

      return result;
    } else {
      var responceJson = loginModelFromJson(responce.body);
      throw Exception('${responceJson.message}');
    }
  }

// !register---->
  Future<RegistrationModel?> createRegistrationModel(
    String? fName,
    String? lName,
    String? email,
    String? password,
    String? cPassword,
    String? gender,
    String? phone,
  ) async {
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/users/register';

    final responce = await http.post(Uri.parse(url), body: {
      "first_name": fName,
      "last_name": lName,
      "email": email,
      "password": password,
      "confirm_password": cPassword,
      "gender": gender,
      "phone_no": phone,
    });
    // ! added new
    final resBody = jsonDecode(responce.body);

    if (responce.statusCode == 200) {
      final resBody = jsonDecode(responce.body);

      //! final  registrationModelFromJson(resBody);
      final response = registrationModelFromJson(responce.body);
      // (response.userMsg);
      return response;
    } else {
      var responceJson = registrationModelFromJson(responce.body);
      throw Exception('${responceJson.userMsg}');
    }
  }

// !______________________HOME PAGE APIS_________________________________

  // !for Home Page------------------------->

  late final Map<String, String> productTyeps = {
    "tables": "1",
    "chairs": "2",
    "sofas": "3",
    "cupboards": "4",
  };
  Future<ProductListModel> getProductList(String proType) async {
    final argumets = {
      'product_category_id': productTyeps[proType.toLowerCase()],
      'limit': '10',
      'page': '1',
    };

    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/products/getList';
    String query = Uri(queryParameters: argumets).query;
    final reqUrl = url + '?' + query;
    final response = await http.get(Uri.parse(reqUrl));

    if (response.statusCode == 200) {
      return ProductListModel.fromJson(jsonDecode(response.body));
    } else {
      var responseJson = productListModelFromJson(response.body);
      throw Exception('${responseJson.data}');
    }
  }

//
//
//
//
// !______________________MY ACCOUNT INFO APIS_________________________________

// ! calling My account user Data details API
  Future<ProfileDetailsModel> getUserData(String token) async {
    String url =
        "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData";

    final response =
        await http.get(Uri.parse(url), headers: {'access_token': '$token'});

    if (response.statusCode == 200) {
      // (response.body);
      return ProfileDetailsModelFromJson(response.body);
    } else {
      var responseJsos = ProfileDetailsModelFromJson(response.body);
      throw Exception('${responseJsos.data}');
    }
  }

  // ! calling Update Details API->
  Future<ProfileEditedModel> editAccountDetails(
      {required String fName,
      required String lName,
      required String email,
      required String dob,
      required String img,
      required String token,
      required String phone}) async {
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/users/update';

    final response = await http.post(Uri.parse(url), headers: {
      'access_token': token,
    }, body: {
      "first_name": fName,
      "last_name": lName,
      "email": email,
      "dob": dob,
      "profile_pic": img,
      "phone": phone,
    });

    if (response.statusCode == 200) {
      (response.body);
      return ProfileEditedModel.fromJson(jsonDecode(response.body));
    } else {
      // ("in API calling");
      (response.statusCode);
      var responseJson = profileEditedModelFromJson(response.body);
      // (responseJson);
      throw Exception(responseJson.userMsg);
    }
  }

// ! Set New Password API-->
  Future<ResetPasswordModel> setPassword(
      {required String token,
      required String oldpass,
      required String pass1,
      required String pass2}) async {
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/users/change';

    final response = await http.post(Uri.parse(url), headers: {
      'access_token': token
    }, body: {
      'old_password': oldpass,
      'password': pass1,
      'confirm_password': pass2,
    });
    if (response.statusCode == 200) {
      (response.body);
      return resetPasswordModelFromJson(response.body);
    } else {
      var res = resetPasswordModelFromJson(response.body);
      throw Exception(res.userMsg);
    }
  }

//
//
//
// !______________________PRODUCT LISTING APIS_________________________________
  // ! for Product List page--------->
  Future<ProductListModel> getProdList(String productListType) async {
    // productType = productType.toLowerCase();
    final argumets = {
      'product_category_id': productTyeps[productListType.toLowerCase()],
      'limit': '10',
      'page': '1',
    };
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/products/getList';

    String query = Uri(queryParameters: argumets).query;
    final reqUrl = url + '?' + query;
    // ?------------------
    final response = await http.get(Uri.parse(reqUrl));

    if (response.statusCode == 200) {
      return ProductListModel.fromJson(jsonDecode(response.body));
    } else {
      var responseJsos = productListModelFromJson(response.body);
      throw Exception('${responseJsos.data}');
    }
  }

// ! Detail APi Calling----->
  Future<ProductDetailModel> getDetail(String productId) async {
    final arguments = {
      'product_id': productId,
    };
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/products/getDetail';

    String query = Uri(queryParameters: arguments).query;
    final _url = url + '?' + query;
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      // ('In Detail Page success');
      // (jsonDecode(response.body));
      return productDetailModelFromJson(response.body);
    } else {
      var responseJson = productDetailModelFromJson(response.body);
      throw Exception('${responseJson.data}');
    }
  }

//
//

// !________________________MY CART APIS_______________________________________

// ! add to cart api--------------------------->
  Future<AddToCartModel> addToCart(int proId, int qty, String token) async {
    const String url =
        "http://staging.php-dev.in:8844/trainingapp/api/addToCart";

    var response = await http.post(Uri.parse(url),
        headers: {"access_token": token},
        body: {"product_id": '$proId', "quantity": '$qty'});
    if (response.statusCode == 200) {
      return addToCartModelFromJson(response.body);
    } else {
      var errorResponse = addToCartModelFromJson(response.body);
      throw Exception(errorResponse.userMsg);
    }
  }

// ! get Items In cart API---------------------------------------------------->
  Future<ItemsInCartModel?> getCartItems({required String token}) async {
    const String url = "http://staging.php-dev.in:8844/trainingapp/api/cart";

    var response =
        await http.get(Uri.parse(url), headers: {"access_token": token});
    // (response.statusCode);
    if (response.statusCode == 200) {
      var responseData = itemsInCartModelFromJson(response.body);
      (responseData.data);
      if (responseData.data != null) {
        return responseData;
      }
      return responseData;
    } else {
      var errorResponse = itemsInCartModelFromJson(response.body);
      throw Exception(errorResponse.status);
    }
  }

// ! Edit Cart API---------->
  Future<EditCartModel> editCartItems(
      {required String token,
      required String proId,
      required String? quantity}) async {
    const String url =
        "http://staging.php-dev.in:8844/trainingapp/api/editCart";

    var response = await http.post(Uri.parse(url), headers: {
      "access_token": token
    }, body: {
      "product_id": proId,
      "quantity": quantity,
    });
    // (response.statusCode);
    if (response.statusCode == 200) {
      var responseData = editCartModelFromJson(response.body);

      return responseData;
    } else {
      var errorResponse = editCartModelFromJson(response.body);
      throw Exception(errorResponse.status);
    }
  }

  // ! Delete Cart API-------------------------------------->
  Future<DeleteCartModel> deleteCartItem(
      {required String token, required String proId}) async {
    const String url =
        "http://staging.php-dev.in:8844/trainingapp/api/deleteCart";
    var response = await http.post(Uri.parse(url),
        headers: {"access_token": token}, body: {"product_id": proId});
    if (response.statusCode == 200) {
      var result = deleteCartModelFromJson(response.body);
      return result;
    } else {
      var errorRes = deleteCartModelFromJson(response.body);
      throw Exception(errorRes.userMsg);
    }
  }

// ! SET RATING_________________________________________>
  Future<ProductRatingModel> setRating(String id, int rating) async {
    String rate = "3";
    if (rating < 3) {
      rate = "3";
    }
    const String url =
        "http://staging.php-dev.in:8844/trainingapp/api/products/setRating";
    var response = await http.post(Uri.parse(url), body: {
      'product_id': id,
      'rating': rate,
    });
    if (response.statusCode == 200) {
      var result = productRatingModelFromJson(response.body);
      (result.userMsg);
      return result;
    } else {
      var errorres = productDetailModelFromJson(response.body);
      throw Exception(errorres.status);
    }
  }

//
//
//
// ! Get MyOrder List-------------------------------->
  Future<MyOrdersListModel> getMyorderList({required String token}) async {
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/orderList';

    var response =
        await http.get(Uri.parse(url), headers: {'access_token': token});

    if (response.statusCode == 200) {
      var result = myOrdersListModelFromJson(response.body);
      // (result.data);
      return result;
    } else {
      var errorRes = myOrdersListModelFromJson(response.body);
      throw Exception(errorRes.userMsg);
    }
  }

  // ! Get MyOrder List-------------------------------->
  Future<MyOrderDetailModel> getOrderDetail(
      {required String token, required int orderId}) async {
    Map<String, String> parameters = {'order_id': "$orderId"};

    String query = Uri(queryParameters: parameters).query;
    const String url =
        'http://staging.php-dev.in:8844/trainingapp/api/orderDetail';
    final reqUrl = url + '?' + query;

    var response =
        await http.get(Uri.parse(reqUrl), headers: {'access_token': token});

    if (response.statusCode == 200) {
      var result = myOrderDetailModelFromJson(response.body);
      (result.data);
      return result;
    } else {
      var errorRes = myOrderDetailModelFromJson(response.body);
      throw Exception(errorRes.status);
    }
  }
}
