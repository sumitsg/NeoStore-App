import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_event.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_password_model.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_state.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class ResetBloc extends Bloc<ResetPassEvent, ResetPasswordState> {
  final AuthRepository authRepository;
  ResetBloc({required this.authRepository}) : super(SubmittingData());

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPassEvent event) async* {
    if (event is ResetButtonPressed) {
      try {
        ResetPasswordModel? resetPasswordModel =
            await authRepository.setPassword(
                token: event.token,
                oldpass: event.curPass,
                pass1: event.pass1,
                pass2: event.pass2);
        ProfileDetailsModel profileDetailsModel =
            await authRepository.getUserData(event.token);

        if (resetPasswordModel.status == 200 &&
            profileDetailsModel.status == 200) {
          yield ResetPasswordState(profileDetailsModel: profileDetailsModel);
        }
      } on Exception catch (e) {
        yield SubmissionFailureState(e.toString());
      }
    }
  }
}
