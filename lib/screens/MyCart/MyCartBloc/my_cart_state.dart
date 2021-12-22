import 'package:neosoft_training_app/screens/MyCart/DeleteCart/delete_cat_model.dart';
import 'package:neosoft_training_app/screens/MyCart/EditCart/edit_cart_model.dart';
import 'package:neosoft_training_app/screens/MyCart/item_in_cart_model.dart';

class MyCartState {
  ItemsInCartModel? itemsInCartModel;
  DeleteCartModel? deleteCartModel;
  EditCartModel? editCartModel;
  MyCartState(
      {this.itemsInCartModel, this.editCartModel, this.deleteCartModel});
}

class SubmittingData extends MyCartState {}

class SubmissionFailureState extends MyCartState {
  String exp;
  SubmissionFailureState(this.exp);
}
