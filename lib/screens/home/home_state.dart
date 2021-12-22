import 'package:neosoft_training_app/screens/MyCart/item_in_cart_model.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';

// abstract class HomePageState {}

class HomeState {
  ProductListModel? productListModel;
  ProfileDetailsModel? profileDetailsModel;
  ItemsInCartModel? itemsInCartModel;
  HomeState(
      {this.productListModel, this.profileDetailsModel, this.itemsInCartModel});
}

class ProductFailureState extends HomeState {
  String exp;
  ProductFailureState(this.exp);
}

class ProductLoading extends HomeState {}

// class MyAccountDetailState {
//   ProfileDetailsModel? profileDetailsModel;
//   MyAccountDetailState({this.profileDetailsModel});
// }
