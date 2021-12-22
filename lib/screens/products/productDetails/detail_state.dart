import 'package:neosoft_training_app/screens/products/productDetails/detail_model.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';

class DetailState {
  ProductDetailModel? productDetailModel;
  DetailState({this.productDetailModel});
}

class FetchFailedState extends DetailState {
  String exp;
  FetchFailedState(this.exp);
}

class DetailLoading extends DetailState {}
