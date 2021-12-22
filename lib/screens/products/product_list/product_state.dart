import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';

class ProductState {
  ProductListModel? productListModel;
  ProductState({this.productListModel});
}

class FetchFailedState extends ProductState {
  String exp;
  FetchFailedState(this.exp);
}

class ProductLoading extends ProductState {}
