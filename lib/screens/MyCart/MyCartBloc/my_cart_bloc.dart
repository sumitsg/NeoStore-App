import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/MyCart/DeleteCart/delete_cat_model.dart';
import 'package:neosoft_training_app/screens/MyCart/EditCart/edit_cart_model.dart';
import 'package:neosoft_training_app/screens/MyCart/MyCartBloc/my_cart_event.dart';
import 'package:neosoft_training_app/screens/MyCart/MyCartBloc/my_cart_state.dart';
import 'package:neosoft_training_app/screens/MyCart/item_in_cart_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  final AuthRepository authRepository;

  MyCartBloc({required this.authRepository}) : super(SubmittingData());

  @override
  Stream<MyCartState> mapEventToState(MyCartEvent event) async* {
    if (event is EditFromCartPressed) {
      try {
        EditCartModel? editcartModel = await authRepository.editCartItems(
            token: event.token,
            proId: event.product_id,
            quantity: event.quantity);
        ItemsInCartModel? itemsInCartModel =
            await authRepository.getCartItems(token: event.token);

        if (editcartModel.status == 200) {
          yield MyCartState(
              editCartModel: editcartModel, itemsInCartModel: itemsInCartModel);
        }
      } on Exception catch (e) {
        yield SubmissionFailureState(e.toString());
      }
    } else if (event is DeleteFromCartPressed) {
      try {
        DeleteCartModel? deleteCartModel = await authRepository.deleteCartItem(
            token: event.token, proId: event.product_id);
        ItemsInCartModel? itemsInCartModel =
            await authRepository.getCartItems(token: event.token);
        if (deleteCartModel.status == 200) {
          yield MyCartState(
              deleteCartModel: deleteCartModel,
              itemsInCartModel: itemsInCartModel);
        }
      } on Exception catch (e) {
        yield SubmissionFailureState(e.toString());
      }
    }
  }
}
