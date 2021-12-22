import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/profile/editProfileBloc/edit_profile_event.dart';
import 'package:neosoft_training_app/screens/profile/editProfileBloc/edit_profile_state.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/profile/profile_edited_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final AuthRepository authRepository;
  EditProfileBloc({required this.authRepository}) : super(SubmittingData());

  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is SubmitDetailButtonPressed) {
      try {
        ProfileEditedModel profileEditedModel =
            await authRepository.editAccountDetails(
                token: event.token,
                fName: event.fname,
                lName: event.lname,
                email: event.email,
                dob: event.dob,
                phone: event.phone,
                img: event.img);
        ProfileDetailsModel profileDetailsModel =
            await authRepository.getUserData(event.token);

        if (profileEditedModel.status == 200) {
          yield EditProfileState(profileDetailsModel: profileDetailsModel);
        }
      } on Exception catch (e) {
        yield SubmissionFailureState(e.toString());
      }
    }
  }
}
