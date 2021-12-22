import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/MyCart/item_in_cart_model.dart';
import 'package:neosoft_training_app/screens/home/home_event.dart';
import 'package:neosoft_training_app/screens/home/home_page.dart';
import 'package:neosoft_training_app/screens/home/home_state.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository authRepository;

  HomeBloc({required this.authRepository}) : super(ProductLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ButtonPressed) {
      try {
        ProductListModel? productListModel =
            await authRepository.getProductList(event.id);
        if (productListModel.status == 200) {
          yield HomeState(productListModel: productListModel);
        }
      } on Exception catch (e) {
        yield ProductFailureState(e.toString());
      }
    } else if (event is MyAccPressed) {
      try {
        ProfileDetailsModel? profileDetails =
            await authRepository.getUserData(event.token);
        if (profileDetails.status == 200) {
          yield HomeState(profileDetailsModel: profileDetails);
        }
      } on Exception catch (e) {
        yield ProductFailureState(e.toString());
      }
    } else if (event is MyCartPressed) {
      try {
        ItemsInCartModel? itemsInCartModel =
            await authRepository.getCartItems(token: event.token);
        if (itemsInCartModel!.status == 200) {
          yield HomeState(itemsInCartModel: itemsInCartModel);
        }
      } on Exception catch (e) {
        yield ProductFailureState(e.toString());
      }
    }
  }
}
