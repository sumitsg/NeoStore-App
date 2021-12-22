import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_event.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_state.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class ProductListBloc extends Bloc<ProductEvent, ProductState> {
  final AuthRepository authRepository;

  ProductListBloc({required this.authRepository}) : super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ButtonClicked) {
      try {
        ProductListModel? prodList = await authRepository.getProdList(event.id);
        if (prodList.status == 200) {
          yield ProductState(productListModel: prodList);
        }
      } on Exception catch (e) {
        yield FetchFailedState(e.toString());
      }
    }
  }
}
