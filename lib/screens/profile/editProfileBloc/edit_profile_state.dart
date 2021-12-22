import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/profile/profile_edited_model.dart';

class EditProfileState {
  ProfileDetailsModel? profileDetailsModel;
  ProfileEditedModel? profileEditedModel;
  EditProfileState({this.profileDetailsModel, this.profileEditedModel});
}

class SubmittingData extends EditProfileState {}

class SubmissionFailureState extends EditProfileState {
  String exp;
  SubmissionFailureState(this.exp);
}
