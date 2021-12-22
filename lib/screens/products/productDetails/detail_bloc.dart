import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_event.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_model.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_state.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class DeatailBloc extends Bloc<DetailEvent, DetailState> {
  final AuthRepository authRepository;

  DeatailBloc({required this.authRepository}) : super(DetailLoading());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is ButtonClicked) {
      try {
        ProductDetailModel productDetailModel =
            await authRepository.getDetail(event.id);

        if (productDetailModel.status == 200) {
          yield DetailState(productDetailModel: productDetailModel);
        }
      } on Exception catch (e) {
        yield FetchFailedState(e.toString());
      }
    }
  }
}
