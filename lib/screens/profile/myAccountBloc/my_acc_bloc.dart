import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/profile/myAccountBloc/my_acc_event.dart';
import 'package:neosoft_training_app/screens/profile/myAccountBloc/my_acc_state.dart';
import 'package:neosoft_training_app/screens/profile/my_account.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class MyAccBloc extends Bloc<ProfileDetailEvent, ProfileDetailState> {
  final AuthRepository authRepository;

  MyAccBloc({required this.authRepository}) : super(ProfileLoading());

  @override
  Stream<ProfileDetailState> mapEventToState(ProfileDetailEvent event) async* {
    if (event is EditDetailPressed) {
      try {
        ProfileDetailsModel profileDetailsModel =
            await authRepository.getUserData(event.token);
        if (profileDetailsModel.status == 200) {
          yield ProfileDetailState(profileDetailsModel: profileDetailsModel);
        }
      } on Exception catch (e) {
        yield ProfileFailureState(e.toString());
      }
    }
  }
}
